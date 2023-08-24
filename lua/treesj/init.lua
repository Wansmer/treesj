local settings = require('treesj.settings')

local M = {
  _mode_to_use = nil,
  _preset_to_use = nil,
}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
end

local function repeatable(fn)
  if settings.settings.dot_repeat then
    M.__repeat = fn
    vim.opt.operatorfunc = "v:lua.require'treesj'.__repeat"
    vim.api.nvim_feedkeys(vim.v.count1 .. 'g@l', 'n', true)
  else
    fn()
  end
end

M.format = function(mode, preset)
  M.nested_format('count', mode, preset)
end

M.toggle = function(preset)
  M.format(nil, preset)
end

M.join = function(preset)
  M.format('join', preset)
end

M.split = function(preset)
  M.format('split', preset)
end

M.nested_format = function(selector, mode, preset)
  require('treesj.format').last_selected = nil
  repeatable(function()
    require('treesj.format')._nested(selector, mode, preset)
  end)
end

M.nested_toggle = function(selector, preset)
  M.nested_format(selector, nil, preset)
end

M.nested_join = function(selector, preset)
  M.nested_format(selector, 'join', preset)
end

M.nested_split = function(selector, preset)
  M.nested_format(selector, 'split', preset)
end

return M
