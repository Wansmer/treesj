local u = require('treesj.utils')
local tu = require('treesj.treesj.utils')

---TreeSJ - wrapper over TS Node
---@class TreeSJ
---@field _root boolean If the current node is the root
---@field _tsnode userdata TSNode instance
---@field _parent TreeSJ|nil TreeSJ instance. Parent of current TreeSJ node
---@field _prev TreeSJ|nil TreeSJ instance. Previous sibling of current TreeSJ node
---@field _next TreeSJ|nil TreeSJ instance. Next sibling of current TreeSJ node
---@field _preset table|nil Preset for current TreeSJ if exist
---@field _text string|string[] Formatted tsnode text
---@field _has_node_to_format boolean Has or not check_descendants for format
---@field _children TreeSJ[] List of children
---@field _observed_range integer[] Range of node consider whitespaces
---@field _root_indent integer|nil Start indent to calculate other insdent when split
local TreeSJ = {}
TreeSJ.__index = TreeSJ

---New TreeSJ instance
---@param tsnode userdata TSNode instance
---@param parent? TreeSJ TreeSJ instance. When parent not passed, the node is recognized as root
function TreeSJ.new(tsnode, parent)
  local preset = u.get_self_preset(tsnode)
  local sr = tsnode:range()
  local ri
  if not parent then
    ri = vim.fn.indent(sr + 1)
  end

  return setmetatable({
    _root = not parent,
    _tsnode = tsnode,
    _parent = parent,
    _prev = nil,
    _next = nil,
    _preset = preset,
    _text = u.get_node_text(tsnode),
    _has_node_to_format = u.has_node_to_format(tsnode),
    _children = {},
    _observed_range = tu.get_observed_range(tsnode),
    _root_indent = ri,
  }, TreeSJ)
end

---Recursive parse current node children and building TreeSJ
function TreeSJ:build_tree()
  local children = u.collect_children(self:tsnode())
  local prev

  if self:without_brackets() then
    u.update_for_no_brackets(self:tsnode(), children)
  end

  for _, child in ipairs(children) do
    local tsj = TreeSJ.new(child, self)

    tsj:_set_prev(prev)
    if tsj:prev() then
      tsj:prev():_set_next(tsj)
    end

    -- TODO: add check for current mode
    if not tsj:is_ignore('split') and tsj:has_preset() then
      local sw = vim.api.nvim_buf_get_option(0, 'shiftwidth')
      tsj._root_indent = tsj:up_indent() + sw
    end

    tsj:build_tree()

    table.insert(self._children, tsj)
    prev = tsj
  end
end

---Checking if the current treesj node is non-bracket block
---@return boolean
function TreeSJ:without_brackets()
  return self:has_preset()
      and u.get_nested_key_value(self:preset('split'), 'node_without_brackets')
    or false
end

---Get indent from previous configured ancestor node
function TreeSJ:up_indent()
  if self:parent():has_preset() and not self:parent():is_ignore('split') then
    return self:parent()._root_indent
  end
  if self:parent() then
    return self:parent():up_indent()
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
  if self._root then
    return self
  end
  return self:parent():root()
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

    self:_update_text(tu._join(self))
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

    self:_update_text(vim.tbl_flatten(tu._split(self)))
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
  if self:without_brackets() then
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
function TreeSJ:_update_text(new_text)
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
  return omit and vim.tbl_contains(omit, self:type()) or false
end

---Return formatted lines of TreeSJ
---@return string[]
function TreeSJ:get_lines()
  local text = self:text()
  return type(text) == 'table' and vim.tbl_flatten(text) or { text }
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

return TreeSJ
