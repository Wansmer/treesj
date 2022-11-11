local settings = require('treesj.settings')

local M = {}

M.setup = function(opts)
  settings._update_settings(opts)
  settings._set_default_keymaps()
  settings._create_commands()
end

M.toggle = function()
  require('treesj.format')._format()
end

M.join = function()
  require('treesj.format')._format('join')
end

M.split = function()
  require('treesj.format')._format('split')
end

return M
