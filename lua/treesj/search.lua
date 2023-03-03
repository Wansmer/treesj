local u = require('treesj.utils')
local notify = require('treesj.notify')
local msg = notify.msg

local M = {}

---Recursively searches for the configured node among the ancestors
---@param node userdata TSNode instance
---@param lang string Language of TSNode
---@return userdata|nil
function M.search_node_up(node, lang)
  if not node then
    return nil
  end

  if not u.get_preset(node:type(), lang) then
    node = node:parent()
    return M.search_node_up(node, lang)
  end

  return node
end

---Recursively searches for a configured node inside the current node and
---returns the first configured node found
---@param node userdata|nil TSNode instance
---@param lang string TSNode lang
---@param targets table List of target node types
---@return userdata|nil, table|nil
function M.search_inside_node(node, lang, targets)
  if not node then
    return nil, nil
  end

  local target_node, use_preset

  for child in node:iter_children() do
    local target_type = targets[child:type()]
    use_preset = target_type and u.get_self_preset(target_type, lang)

    if use_preset then
      target_node = child
    else
      target_node, use_preset = M.search_inside_node(child, lang, targets)
    end

    if target_node then
      break
    end
  end

  return target_node, use_preset
end

---Get target node and node data
---@param node userdata TSNode instance
---@param lang string TSNode language
---@return table|nil
function M.search_node(node, lang)
  local viewed = {}
  local tsn_data = { lang = lang, parent = nil }
  local preset

  while node do
    node = M.search_node_up(node, lang)
    preset = node and u.get_preset(node:type(), lang)

    if not node then
      return nil
    end

    local targets = preset.target_nodes

    local has_targets = targets and not vim.tbl_isempty(targets)
    local not_viewed = not vim.tbl_contains(viewed, node)

    if has_targets and not_viewed then
      local with_target = node
      table.insert(viewed, with_target)

      node, preset = M.get_node_from_field(node, lang, targets)

      if not node then
        node, preset = M.search_inside_node(with_target, lang, targets)
      end

      if node then
        break
      else
        node = with_target:parent()
      end
    else
      break
    end
  end

  return vim.tbl_extend('force', tsn_data, { tsnode = node, preset = preset })
end

function M.get_node_from_field(node, lang, targets)
  for node_type, use_preset in pairs(targets) do
    local fields = node:field(node_type)
    local preset = u.get_self_preset(use_preset, lang)

    if not vim.tbl_isempty(fields) and preset then
      return fields[1], preset
    end
  end
  return nil, nil
end

---Return the closest configured node if found or nil
---@param node userdata|nil TSNode instance
---@return table
function M.get_configured_node(node)
  if not node then
    error(msg.node_not_received, 0)
  end

  local lang = u.get_node_lang(node)
  if not u.is_lang_support(lang) then
    error(msg.no_configured_lang:format(lang), 0)
  end

  local start_node_type = node:type()
  local data = M.search_node(node, lang)

  if not data or not data.tsnode then
    error(msg.no_configured_node:format(start_node_type, lang), 0)
  end

  return data
end

return M
