local settings = require('treesj.settings')

local M = {}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
end

local function set_opfunc(dir)
  vim.opt.operatorfunc = "v:lua.require'treesj'.__" .. dir
  return 'g@l'
end

M.__toggle = function()
  require('treesj.format')._format()
end

M.__split = function()
  require('treesj.format')._format('split')
end

M.__join = function()
  require('treesj.format')._format('join')
end

M.toggle = function()
  return set_opfunc('toggle')
end

M.join = function()
  return set_opfunc('join')
end

M.split = function()
  return set_opfunc('split')
end

return M
