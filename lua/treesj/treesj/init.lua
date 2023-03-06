local u = require('treesj.utils')
local tu = require('treesj.treesj.utils')

---TreeSJ - wrapper over TS Node
---@class TreeSJ
---@field _root boolean If the current node is the root
---@field _tsnode userdata TSNode instance
---@field _lang string TSNode language
---@field _imitator boolean Imitator first/last node for non-bracket blocks
---@field _parent TreeSJ|nil TreeSJ instance. Parent of current TreeSJ node
---@field _prev TreeSJ|nil TreeSJ instance. Previous sibling of current TreeSJ node
---@field _next TreeSJ|nil TreeSJ instance. Next sibling of current TreeSJ node
---@field _preset table|nil Preset for current TreeSJ if exist
---@field _text string|string[] Formatted tsnode text
---@field _has_node_to_format boolean Has or not check_descendants for format
---@field _children TreeSJ[] List of children
---@field _observed_range integer[] Range of node consider whitespaces
---@field _root_indent integer|nil Start indent to calculate other insdent when split
---@field _remove boolean Marker if node should be removed from tree
local TreeSJ = {}
TreeSJ.__index = TreeSJ

---New TreeSJ instance
---@param tsn_data table TSNode data { tsnode = TSNode|table, preset = table|nil, lang = string, parent = TreeSJ|nil}
function TreeSJ.new(tsn_data)
  local root_preset = tsn_data.parent and tsn_data.parent:root():preset() or nil
  local tsnode = tsn_data.tsnode

  local is_tsn = tu.is_tsnode(tsnode)
  local hntf = is_tsn and u.has_node_to_format(tsnode, root_preset) or false
  local text = is_tsn and u.get_node_text(tsn_data.tsnode) or tsnode:text()
  local range = is_tsn and tu.get_observed_range(tsnode) or { tsnode:range() }
  local preset = tsn_data.preset
    and vim.tbl_deep_extend('force', {}, tsn_data.preset)

  local ri
  if not tsn_data.parent then
    ri = vim.fn.indent(range[1] + 1)
  end

  return setmetatable({
    _root = not tsn_data.parent,
    _tsnode = tsnode,
    _lang = tsn_data.lang,
    _imitator = not is_tsn,
    _parent = tsn_data.parent,
    _prev = nil,
    _next = nil,
    _preset = preset,
    _text = text,
    _has_node_to_format = hntf,
    _children = {},
    _observed_range = range,
    _root_indent = ri,
    _remove = false,
  }, TreeSJ)
end

---Recursive parse current node children and building TreeSJ
---@param mode string
function TreeSJ:build_tree(mode)
  local children = u.collect_children(self:tsnode(), u.skip_empty_nodes)
  local prev

  -- NOTE: `self:preset()` didn't should be saving in variable because
  -- it can be changing in life cycle function
  if self:preset(mode) then
    tu.add_framing_nodes(children, self:preset(mode), self)

    -- LIFECYCLE: before_build_tree
    if self:has_lifecycle('before_build_tree', mode) then
      local fn = self:preset(mode).lifecycle.before_build_tree
      children = fn(children, self:preset(mode), self)
    end

    tu.handle_last_separator(children, self:preset(mode))
  end

  for _, child in ipairs(children) do
    local tsn_data = {
      tsnode = child,
      preset = u.get_self_preset(child:type(), self._lang),
      lang = self._lang,
      parent = self,
    }

    local tsj = TreeSJ.new(tsn_data)

    tsj:_set_prev(prev)
    if tsj:prev() then
      tsj:prev():_set_next(tsj)
    end

    if not tsj:is_ignore('split') and tsj:has_preset() then
      local is_norm = tsj:root():preset('split').inner_indent == 'normal'
      local need_sw = not (tsj:is_omit() or tsj:parent():is_omit() or is_norm)

      local sw = need_sw and vim.fn.shiftwidth() or 0

      tsj._root_indent = tsj:get_prev_indent() + sw
    end

    if tu.is_tsnode(child) then
      tsj:build_tree(mode)
    end

    table.insert(self._children, tsj)
    prev = tsj
  end

  -- LIFECYCLE: after_build_tree
  if self:has_lifecycle('after_build_tree', mode) then
    local fn = self:preset(mode).lifecycle.after_build_tree
    self._children = fn(self._children)
  end
end

---Checking if current TreeSJ has lifecycle callback
---@param cycle string Lifecycle name
---@param mode string
function TreeSJ:has_lifecycle(cycle, mode)
  if self:has_preset() and self:preset(mode).lifecycle then
    local fn = self:preset(mode).lifecycle[cycle]
    return u.tobool(fn and vim.is_callable(fn))
  else
    return false
  end
end

---Checking if the current treesj node is non-bracket block
---@return boolean
function TreeSJ:non_bracket()
  return self:has_preset()
      and u.get_nested_key_value(self:preset(), 'non_bracket_node')
    or false
end

---Get indent from previous configured ancestor node
function TreeSJ:get_prev_indent()
  if self:parent():has_preset() and not self:parent():is_ignore('split') then
    return self:parent()._root_indent
  end
  if self:parent() then
    return self:parent():get_prev_indent()
  end
end

---Get child of TreeSJ by index
---@param index integer
---@return TreeSJ
function TreeSJ:child(index)
  return self._children[index]
end

---Get root of TreeSJ
---@return TreeSJ TreeSJ instance
function TreeSJ:root()
  return self._root and self or self:parent():root()
end

---Merge TreeSJ to one line for replace start text
function TreeSJ:join()
  if self:has_preset() or self:has_to_format() then
    local root = self:root()

    if self:has_to_format() and root:preset('join').recursive then
      for child in self:iter_children() do
        if not child:is_ignore('join') then
          child:join()
        end
      end
    end

    self:update_text(tu._join(self))
  end
end

---Merge TreeSJ to lines for replace start text
function TreeSJ:split()
  if self:has_preset() or self:has_to_format() then
    local root = self:root()

    if self:has_to_format() and root:preset('split').recursive then
      for child in self:iter_children() do
        if not child:is_ignore('split') then
          child:split()
        end
      end
    end

    local lines = tu.remove_empty_middle_lines(vim.tbl_flatten(tu._split(self)))

    self:update_text(lines)
  end
end

---Checking if the current node must be ignored while recursive formatting
---@param mode string Current mode (split|join)
---@return boolean
function TreeSJ:is_ignore(mode)
  local p = self:root():preset(mode)
  return p and vim.tbl_contains(p.recursive_ignore, self:type()) or false
end

---Get TSNode of current
---@return userdata
function TreeSJ:tsnode()
  return self._tsnode
end

---Get parent node
---@return TreeSJ|nil
function TreeSJ:parent()
  return self._parent
end

---Get left side node
---@return TreeSJ|nil
function TreeSJ:prev()
  return self._prev
end

---Get right side node
---@return TreeSJ|nil
function TreeSJ:next()
  return self._next
end

---Set left side node
---@param node TreeSJ TreeSJ instance
function TreeSJ:_set_prev(node)
  self._prev = node
end

---Set right side node
---@param node TreeSJ TreeSJ instance
function TreeSJ:_set_next(node)
  self._next = node
end

---Get type of current node
---@return string
function TreeSJ:type()
  return self._tsnode:type()
end

---Get range of current node
---@return integer[]
function TreeSJ:range()
  if self:non_bracket() then
    local sr, sc, er, ec
    sr, sc = self:child(1):tsnode():range()
    _, _, er, ec = self:child(#self._children):tsnode():range()
    return { sr, sc, er, ec }
  end
  return { self._tsnode:range() }
end

---Get observed range of current node
---@return integer[]
function TreeSJ:o_range()
  return self._observed_range
end

---Get updated text of current node
---@return string|string[]
function TreeSJ:text()
  return self._text
end

---Updated text of current node
---@param new_text string|string[]
function TreeSJ:update_text(new_text)
  self._text = new_text
end

---True if current node contains descendants to format
---@return boolean
function TreeSJ:has_to_format()
  return self._has_node_to_format
end

---Get preset for for current node
---@param mode? string|nil Current mode (split|join)
---@return table|nil
function TreeSJ:preset(mode)
  if self:has_preset() then
    return mode and self._preset[mode] or self._preset
  end
  return nil
end

---Get parent preset
---@param mode? string Current mode (split|join)
---@return table|nil
function TreeSJ:parent_preset(mode)
  local parent = self:parent()
  if parent and parent:has_preset() then
    return mode and parent:preset(mode) or parent:preset()
  end
  return nil
end

---Checking if the current node is configured
---@return boolean
function TreeSJ:has_preset()
  return u.tobool(self._preset)
end

---Checking if the current node is first among sibling
---@return boolean
function TreeSJ:is_first()
  return not u.tobool(self:prev())
end

---Checking if the current node is last among sibling
---@return boolean
function TreeSJ:is_last()
  return not u.tobool(self:next())
end

---Checking if the current node is first or is last among sibling
---@return boolean
function TreeSJ:is_framing()
  return self:is_last() or self:is_first()
end

---Checking if the text of current node contains at 'preset.omit'
---@return boolean
function TreeSJ:is_omit()
  local omit = u.get_nested_key_value(self:parent_preset(), 'omit')
  return omit and u.check_match(omit, self) or false
end

---Checking if the current TreeSJ is node-imitator
---@return boolean
function TreeSJ:is_imitator()
  return self._imitator
end

---Return formatted lines of TreeSJ
---@return string[]
function TreeSJ:get_lines()
  local text = self:text()
  return type(text) == 'table' and text or { text }
end

function TreeSJ:collect_text()
  local res = {}
  for child in self:iter_children() do
    if child:has_preset() or child:has_to_format() then
      table.insert(res, child:get_lines())
    else
      table.insert(res, child:text())
    end
  end
  return res
end

function TreeSJ:remove()
  self._remove = true
end

---Iterate all TreeSJ instance children
---@return function, table
function TreeSJ:iter_children()
  local index = 0
  local function iterator(tbl)
    index = index + 1
    return tbl[index]
  end
  return iterator, self._children
end

function TreeSJ:update_preset(new_preset, mode)
  if self._preset then
    if mode then
      self._preset[mode] =
        vim.tbl_deep_extend('force', self._preset[mode], new_preset)
    else
      self._preset = vim.tbl_deep_extend('force', self._preset, new_preset)
    end
  end
end

return TreeSJ
