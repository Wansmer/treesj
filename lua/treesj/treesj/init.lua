local notify = require('treesj.notify')
local msg = notify.msg
local u = require('treesj.utils')
local tu = require('treesj.treesj.utils')
local search = require('treesj.search')

---TreeSJ - wrapper over TS Node
---@class TreeSJ
---@field _root boolean If the current node is the root
---@field _tsnode TSNode|table TSNode instance or TSNode imitator
---@field _lang string TSNode language
---@field _imitator boolean Tree if _tsnode is imitator
---@field _parent TreeSJ|nil TreeSJ instance. Parent of current TreeSJ node
---@field _prev TreeSJ|nil TreeSJ instance. Previous sibling of current TreeSJ node
---@field _next TreeSJ|nil TreeSJ instance. Next sibling of current TreeSJ node
---@field _preset table|nil Preset for current TreeSJ if exist. Include both modes
---@field _text string|string[] Formatted tsnode text. Can be string[] when `recursive` is true in preset
---@field _children TreeSJ[] List of children
---@field _root_indent integer|nil Start indent to calculate other insdent when split
---@field _mode 'split'|'join' Current mode
---@field _copy_from_self boolean Marker that the current instance is a copy of itself,
---wrapped with TreeSJ:wrap({...}, 'wrap' )
local TreeSJ = {}
TreeSJ.__index = TreeSJ

---New TreeSJ instance
---@param tsn_data {tsnode=TSNode|table, preset=table|nil, lang=string, parent=TreeSJ|nil, from_self=boolean, mode=string}
function TreeSJ.new(tsn_data)
  local tsnode = tsn_data.tsnode
  local preset = tsn_data.preset
  local lang = tsn_data.lang
  local parent = tsn_data.parent
  local from_self = tsn_data.from_self

  local is_tsn = tu.is_tsnode(tsnode)
  local text = is_tsn and tu.get_node_text(tsnode) or tsnode:text()

  local ri
  if not tsn_data.parent then
    local range = { tsnode:range() }
    ri = vim.fn.indent(range[1] + 1)
  end

  return setmetatable({
    _root = not tsn_data.parent,
    _tsnode = tsnode,
    _lang = lang,
    _imitator = not is_tsn,
    _parent = parent,
    _prev = nil,
    _next = nil,
    _preset = preset,
    _text = text,
    _children = {},
    _root_indent = ri,
    _mode = tsn_data.mode,
    _copy_from_self = from_self,
  }, TreeSJ)
end

---Creating a new TreeSJ instance as a child of current TreeSJ.
---  - data: {text=string, type=string|nil, copy_from=TreeSJ|nil}
---      The "copy_from" field is used if a node needs to be duplicated and expects TreeSJ.
---      If a TreeSJ instance is passed to it, then the "text" and "type" fields will be ignored.
---  - index: If index present, puts it in children list and returned this child,
---      if not – returned child, but not puts it in children list. Index can be a negative value,
---      meaning insert from the end. If an index is specified that is outside the list of children,
---      then `nil` will be returned.
---@param data {text=string, type=string|nil, copy_from=TreeSJ|nil}. If `type` not present, uses value of `text`
---@param index? integer Index where the child should be inserted.
---@return TreeSJ|nil
function TreeSJ:create_child(data, index)
  local tsnode, preset
  local from_self = false
  local copy = data.copy_from

  if copy and (getmetatable(copy) == getmetatable(self)) then
    tsnode = copy:tsnode()
    preset = tsnode:named()
        and search.get_self_preset(tsnode:type(), self._lang)
      or nil
    from_self = copy == self
  else
    tsnode = tu.imitate_tsn(self, data)
  end

  local child = TreeSJ.new({
    tsnode = tsnode,
    preset = preset,
    lang = self._lang,
    parent = self,
    mode = self._mode,
    from_self = from_self,
  })

  if copy then
    tu.handle_indent(child)
    child:_build_tree()
  end

  if index then
    local children = self:children()
    local max_index = #children + 1
    local min_index = 1
    index = tu.fix_index(index, #children)

    if min_index <= index and index <= max_index then
      table.insert(children, index, child)
      self:update_children(children)
    else
      return
    end
  end

  return child
end

--[[ Work with children ]]

---Iterate all TreeSJ instance children.
---Use: `... for child, index in tsj:iter_children() do ...`
---@return function, TreeSJ[]
function TreeSJ:iter_children()
  local index = 0
  local function iterator(tbl)
    index = index + 1
    return tbl[index], index
  end
  return iterator, self._children
end

---Get the child of the current node, using its `type` (`tsj:type()`) or `index`.
--- - The `index` can be a negative value, which means to search from the end of the list.
--- - If a `type` is passed, the first element found will be returned.
---   To get an array of similar elements, use `TreeSJ:children(types)`.
---@param type_or_index number|string Type of TreeSJ child or it index in children list
---@return TreeSJ|nil
function TreeSJ:child(type_or_index)
  if type(type_or_index) == 'number' then
    type_or_index = tu.fix_index(type_or_index, #self:children())
    return self:children()[type_or_index]
  else
    for child in self:iter_children() do
      if child:type() == type_or_index then
        return child
      end
    end
  end
end

---Removes children by the passed types or index.
---@param types_or_index string|string[]|integer Type, types, or index of child to remove
function TreeSJ:remove_child(types_or_index)
  if type(types_or_index) == 'number' then
    types_or_index = tu.fix_index(types_or_index, #self._children)
    table.remove(self._children, types_or_index)
    self:update_children(self._children)
  else
    local remove = type(types_or_index) == 'table' and types_or_index
      or { types_or_index }
    local check = function(child)
      return not vim.tbl_contains(remove, child:type())
    end
    self:update_children(vim.tbl_filter(check, self._children))
  end
end

---Checks if the specified types of children exist among the list of children.
---If types are omitted, checks that there is at least one child.
---@param types? string[]
---@return boolean
function TreeSJ:has_children(types)
  if not types then
    return #self:children() > 0
  else
    return u.every(types, function(t)
      return self:child(t)
    end)
  end
end

---Get the children of the current TreeSJ.
---Returns all children if `types` are omitted, otherwise returns all children of the listed types.
---@param types? string[] List-like table with child's types for filtering
---@return TreeSJ[]
function TreeSJ:children(types)
  local children = vim.list_extend({}, self._children)
  if types then
    children = vim.tbl_filter(function(child)
      return vim.tbl_contains(types, child:type())
    end, children)
  end
  return children
end

---Updated children list of current TreeSJ
---@param children TreeSJ[]
function TreeSJ:update_children(children)
  if type(children) ~= 'table' then
    return
  end
  self._children = tu.linking_tree(children)
end

---Creates the first and last elements in the list of children of the current TreeSJ.
--- - If the `wrap` mode is passed (the default), then a new list of children is created with one element as itself,
---   and the wrapping elements are added to it.
--- - If the `inline` mode is passed, then the real list of children of the current TreeSJ is used to add framing elements.
---@param data table { left = string, right = string }
---@param mode? 'wrap'|'inline' 'wrap' by default
function TreeSJ:wrap(data, mode)
  mode = mode and mode or 'wrap'
  local left = self:create_child({ text = data.left, type = 'left_bracket' })
  local right = self:create_child({ text = data.right, type = 'right_bracket' })
  local children = mode == 'wrap'
      and { self:create_child({ copy_from = self }) }
    or self:children()

  table.insert(children, 1, left)
  table.insert(children, right)

  self:update_children(children)
end

---Helps to swap elements by their indexes
---@param index1 integer
---@param index2 integer
function TreeSJ:swap_children(index1, index2)
  local children = self:children()
  local first = children[index1]
  local second = children[index2]
  children[index1] = second
  children[index2] = first
  self:update_children(children)
end

--[[ Work with TreeSJ data ]]

---Get node type of current TreeSJ
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

---Get updated text of current node
---@return string|table
function TreeSJ:text()
  return self._text
end

---Updated text of current node
---@param new_text string|string[]
function TreeSJ:update_text(new_text)
  self._text = new_text
end

---Get root treesj-node of current TreeSJ
---@return TreeSJ TreeSJ instance
function TreeSJ:root()
  return self._root and self or self:parent():root()
end

---Get TSNode or TSNode imitator of current
---@return TSNode|table TSNode or TSNode imitator
function TreeSJ:tsnode()
  return self._tsnode
end

---Get parent TreeSJ
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

--[[ Work with TreeSJ conditions ]]

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
  return omit and tu.check_match(omit, self) or false
end

---Checking if the current TreeSJ is node-imitator
---@return boolean
function TreeSJ:is_imitator()
  return self._imitator
end

---Checking if the current TreeSJ node is non-bracket block
---@return boolean
function TreeSJ:non_bracket()
  local preset = self:preset(self._mode)
  return u.tobool(preset and preset.non_bracket_node)
end

---Checking if the current node must be ignored while recursive formatting
---@return boolean
function TreeSJ:is_ignore()
  local mode = self._mode
  local p = self:root():preset(mode)
  return p and vim.tbl_contains(p.recursive_ignore, self:type()) or false
end

---Checks if the TreeSJ contains descendants that need to be formatted
---@return boolean
function TreeSJ:has_to_format()
  local ignore = self:root():preset(self._mode).recursive_ignore

  for child in self:iter_children() do
    if not child:is_imitator() and child:tsnode():named() then
      local tsnode = child:tsnode()
      local hp = child:has_preset(self._mode)

      -- It needs to be applied in a loop to handle cases where any of the nodes were copied from themselves
      if hp or search.has_node_to_format(tsnode, ignore, self._lang) then
        return true
      end
    end
  end

  return false
end

---Returns true if the current TreeSJ will be formatted
---@return boolean
function TreeSJ:will_be_formatted()
  local root = self:root()

  if self == root then
    return true
  end

  local mode = self._mode
  return root:preset(mode).recursive
    and (self:has_preset(mode) or self:has_to_format())
end

--[[ Work with preset ]]

---Checking if the current TreeSJ is configured
---@param mode? 'split'|'join' Current mode (split|join)
---@return boolean
function TreeSJ:has_preset(mode)
  local has = self._preset and (mode and self._preset[mode] or self._preset)
  return u.tobool(has)
end

---Get preset for current TreeSJ
---@param mode? 'split'|'join' Current mode (split|join)
---@return table|nil
function TreeSJ:preset(mode)
  if self:has_preset() then
    return mode and self._preset[mode] or self._preset
  end
  return nil
end

---Get the preset of the TreeSJ parent
---@param mode? 'split'|'join' Current mode (split|join)
---@return table|nil
function TreeSJ:parent_preset(mode)
  local parent = self:parent()
  if parent and parent:has_preset() then
    return mode and parent:preset(mode) or parent:preset()
  end
  return nil
end

---Updates the presets for the current node.
---@param new_preset table|nil
---@param mode? 'split'|'join'
function TreeSJ:update_preset(new_preset, mode)
  if self._preset then
    if type(new_preset) == 'nil' then
      self._preset = nil
    else
      if mode then
        self._preset[mode] =
          vim.tbl_deep_extend('force', self._preset[mode], new_preset)
      else
        self._preset = vim.tbl_deep_extend('force', self._preset, new_preset)
      end
    end
  end
end

--[[ Private, not use in presets ]]

---Recursive parse current node children and building TreeSJ
function TreeSJ:_build_tree()
  local mode = self._mode
  local preset = self:preset(mode)
  local children = tu.collect_children(self:tsnode(), tu.skip_empty_nodes)

  if preset and preset.shrink_node then
    if self ~= self:root() then
      self:update_preset(nil)
    else
      local target = self:preset(mode).shrink_node
      local _, from = tu.get_by_type(children, target.from)
      local _, to = tu.get_by_type(children, target.to)
      from = from and from or 1
      to = to and to or #children
      children = vim.list_slice(children, from, to)
    end
  end

  for _, child in ipairs(children) do
    local self_preset

    if child:named() then
      self_preset = search.get_self_preset(child:type(), self._lang)
    end

    local tsj = TreeSJ.new({
      tsnode = child,
      preset = self_preset,
      lang = self._lang,
      parent = self,
      mode = mode,
      from_self = false,
    })

    tu.handle_indent(tsj)

    if tu.is_tsnode(child) then
      tsj:_build_tree()
    end

    table.insert(self._children, tsj)
  end

  self:update_children(self:children())

  if preset then
    tu.handle_framing_nodes(self, preset)
    tu.handle_last_separator(self, preset)

    local format_tree = preset.format_tree
    -- Don't run `format_tree` if node is copied from itself and uses the same preset,
    -- because it will be endless recursion
    local is_run = not self._copy_from_self and true
      or (self:parent_preset(mode).__info.node ~= preset.__info.node)

    if type(format_tree) == 'function' and is_run then
      local ok, error = pcall(preset.format_tree, self)
      if not ok then
        notify.warn(
          msg.custom_func:format('format_tree', preset.__info.node, error)
        )
      end
    end
  end
end

---Merge TreeSJ to one line for replace start text
function TreeSJ:_format()
  if self:has_preset() or self:has_to_format() then
    local mode = self._mode
    local root = self:root()

    if self:has_to_format() and root:preset(mode).recursive then
      for child in self:iter_children() do
        if not child:is_ignore() then
          child:_format()
        end
      end
    end

    local preset = self:preset(mode)
    local lines

    if mode == 'join' then
      lines = tu._join(self)
    else
      lines = tu.remove_empty_middle_lines(vim.tbl_flatten(tu._split(self)))
    end

    local format_lines = preset and preset.format_resulted_lines

    if format_lines then
      local ok, output = pcall(format_lines, lines)
      local correct = type(output) == 'table' and u.every(output, u.is_string)

      if not (ok and correct) then
        local mess = (not correct and ok) and msg.wrong_resut or msg.custom_func
        mess = mess:format('format_resulted_lines', preset.__info.node, output)
        error(mess, 0)
      end

      lines = output
    end

    lines = mode == 'split' and lines or table.concat(lines)
    self:update_text(lines)
  end
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

---Return formatted lines of TreeSJ
---@return string[]
function TreeSJ:_get_lines()
  local text = self:text()
  return type(text) == 'table' and text or { text }
end

---Get indent from previous configured ancestor node
function TreeSJ:_get_prev_indent()
  if self:parent() then
    if self:parent():has_preset() and not self:parent():is_ignore() then
      return self:parent()._root_indent
    end
    return self:parent():_get_prev_indent()
  end
  return 0
end

return TreeSJ
