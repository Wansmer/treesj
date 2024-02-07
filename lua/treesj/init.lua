local settings = require('treesj.settings')

local M = {
  mode_to_use = nil,
  preset_to_use = nil,
}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
end

M.__format = function()
  require('treesj.format')._format(M.mode_to_use, M.preset_to_use)
end

local function perform(mode, preset)
  M.mode_to_use = mode
  M.preset_to_use = preset
  vim.opt.operatorfunc = "v:lua.require'treesj'.__format"
  vim.api.nvim_feedkeys('g@l', 'nix', true)
end

M.toggle = function(preset)
  perform(nil, preset)
end

M.join = function(preset)
  perform("join", preset)
end

M.split = function(preset)
  perform("split", preset)
end

return M
