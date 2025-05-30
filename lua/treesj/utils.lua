local M = {}

M.is_list = vim.fn.has('nvim-0.10') == 1 and vim.islist or vim.tbl_islist

M.flatten = (function()
  if vim.fn.has('nvim-0.11') == 1 then
    return function(t)
      return vim.iter(t):flatten():totable()
    end
  else
    return function(t)
      return vim.tbl_flatten(t)
    end
  end
end)()

---Convert any type to boolean
---@param val any
---@return boolean
function M.tobool(val)
  return val and true or false
end

---Checking if the string or table is is is empty
---@param val string|table
---@return boolean
function M.is_empty(val)
  if type(val) == 'table' then
    return vim.tbl_isempty(val)
  elseif type(val) == 'string' then
    return val == ''
  else
    return false
  end
end

---Checking if every item of list meets the condition.
---Empty list or non-list table, returning false.
---@param tbl table List-like table
---@param cb function Callback for checking every item
---@return boolean
function M.every(tbl, cb)
  if type(tbl) ~= 'table' or not M.is_list(tbl) or M.is_empty(tbl) then
    return false
  end

  for _, item in ipairs(tbl) do
    if not cb(item) then
      return false
    end
  end

  return true
end

---Checking if some item of list meets the condition.
---Empty list or non-list table, returning false.
---@param tbl table List-like table
---@param cb function Callback for checking every item
---@return boolean
function M.some(tbl, cb)
  if not M.is_list(tbl) or M.is_empty(tbl) then
    return false
  end

  for _, item in ipairs(tbl) do
    if cb(item) then
      return true
    end
  end

  return false
end

---Recursively finding key in table and return its value if found or nil
---@param tbl table|nil Dict-like table
---@param target_key string Name of target key
---@return any|nil
function M.get_nested_key_value(tbl, target_key)
  if not tbl or M.is_list(tbl) then
    return nil
  end
  local found
  for key, val in pairs(tbl) do
    if key == target_key then
      return val
    end
    if type(val) == 'table' and not M.is_list(val) then
      found = M.get_nested_key_value(val, target_key)
    end
    if found then
      return found
    end
  end
  return nil
end

function M.is_string(el)
  return type(el) == 'string'
end

function M.is_table(el)
  return type(el) == 'table'
end

return M
