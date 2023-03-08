local M = {}

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
  if not vim.tbl_islist(tbl) or M.is_empty(tbl) then
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
  if not vim.tbl_islist(tbl) or M.is_empty(tbl) then
    return false
  end

  for _, item in ipairs(tbl) do
    if cb(item) then
      return true
    end
  end

  return false
end

return M
