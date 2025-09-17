local M = {}
local meta_M = {}
M = setmetatable(M, meta_M)
function M.selector(nodes)
  local c = vim.v.count1
  return nodes[c], c
end
return M
