local settings = require('treesj.settings')

local M = {}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
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

local function set_opfunc_and_format(dir)
  vim.opt.operatorfunc = "v:lua.require'treesj'.__" .. dir
  vim.api.nvim_feedkeys('g@l', 'nx', true)
end

local function format(dir)
  if settings.settings.dot_repeat then
    set_opfunc_and_format(dir)
  else
    M['__' .. dir]()
  end
end

M.toggle = function()
  format('toggle')
end

M.join = function()
  format('join')
end

M.split = function()
  format('split')
end

return M
