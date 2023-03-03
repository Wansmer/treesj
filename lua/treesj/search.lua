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

  if not u.has_preset(node) then
    node = node:parent()
    return M.search_node_up(node, lang, processed)
  end

  return node
end

---Recursively searches for a configured node inside the current node and
---returns the first configured node found
---@param node userdata TSNode instance
---@param targets? table List of target node types
---@return userdata|nil
function M.search_inside_node(node, targets)
  if not node then
    return nil
  end

  local target_node
  targets = targets or u.get_targets(node)

  for child in node:iter_children() do
    local target_preset = targets[child:type()]
    if target_preset then
      target_node = child
    else
      target_node = M.search_inside_node(child, targets)
    end

    if target_node and u.has_preset(target_node) then
      return target_node
    end
  end

  return nil
end

function M.search_node(node, lang)
  local processed = {}

  while node do
    node = M.search_node_up(node, lang)
    local has_targets = node and u.has_targets(node)
    local not_processed = node and not vim.tbl_contains(processed, node)
    local preset = {}

    if has_targets and not_processed then
      local with_target = node
      table.insert(processed, with_target)
      node = M.search_inside_node(node)

      if not node then
        node = with_target:parent()
      else
        return node
      end
    else
      return node
    end
  end
end

---Return the closest configured node if found or nil
---@param node userdata|nil TSNode instance
---@return userdata
function M.get_configured_node(node)
  if not node then
    error(msg.node_not_received, 0)
  end

  local lang = u.get_node_lang(node)
  if not u.is_lang_support(lang) then
    error(msg.no_configured_lang:format(lang), 0)
  end

  local start_node_type = node:type()
  node = M.search_node(node, lang)

  if not node then
    error(msg.no_configured_node:format(start_node_type, lang), 0)
  end

  return node
end

return M
