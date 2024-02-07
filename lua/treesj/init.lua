local settings = require('treesj.settings')

local M = {}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
end

M.__toggle = function(_, preset)
  require('treesj.format')._format(nil, preset)
end

M.__split = function(_, preset)
  require('treesj.format')._format('split', preset)
end

M.__join = function(_, preset)
  require('treesj.format')._format('join', preset)
end

local function set_opfunc_and_format(dir)
  vim.opt.operatorfunc = "v:lua.require'treesj'.__" .. dir
  vim.api.nvim_feedkeys('g@l', 'nix', true)
end

local function format(data)
  local dir, preset = data.dir, data.preset
  if settings.settings.dot_repeat and not preset then
    set_opfunc_and_format(dir)
  else
    M['__' .. dir](_, preset)
  end
end

M.toggle = function(preset)
  format({ dir = 'toggle', preset = preset })
end

M.join = function(preset)
  format({ dir = 'join', preset = preset })
end

M.split = function(preset)
  format({ dir = 'split', preset = preset })
end

return M
