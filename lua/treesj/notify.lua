local notify_ok, _ = pcall(require, 'notify')
local settings = require('treesj.settings').settings

local PLUGIN_NAME = notify_ok and 'TreeSJ: split/join code block' or 'TreeSJ'

local M = {}

M.msg = {
  no_detect_node = 'No detected node at cursor',
  no_configured_lang = 'Language "%s" is not configured',
  contains_error = 'The node "%s" or its descendants contain a syntax error and cannot be %s',
  no_configured_node = 'Node "%s" for lang "%s" is not configured',
  no_contains_target_node = 'Node "%s" has no contains descendants for split/join',
  ts_not_found = 'Nvim-treesitter not found. TreeSJ required treesitter for work.',
  no_format_with = 'Cannot %s "%s" containing node from one of this: %s',
  extra_longer = 'Cannot "join" node longer than %s symbols. Check your settings to change it.',
  version_not_support = 'Current version of neovim is "0.%s". TreeSJ requires version "0.8" or higher',
  node_not_received = 'Node not received',
  node_is_disable = 'Action "%s" for node "%s" is disabled in preset',
  custom_func = 'Something went wrong in function "%s" from preset for "%s": %s',
  wrong_resut = 'Function "%s" from preset for "%s" returned wrong format for new lines',
  no_ts_parser = 'Treesitter parser not found for current buffer'
}

---Wraper for vim.notify and nvim-notify
---@param msg string Message for nofification
---@param level number vim.levels[level]
---@vararg string Strings for substitute
M.notify = function(msg, level, ...)
  if settings.notify then
    msg = msg:format(...)
    level = level or vim.log.levels.INFO

    if notify_ok then
      vim.notify(msg, level, {
        title = PLUGIN_NAME,
      })
    else
      vim.notify(('[%s]: %s'):format(PLUGIN_NAME, msg), level)
    end
  end
end

M.error = function(msg, ...)
  M.notify(msg, vim.log.levels.ERROR, ...)
end

M.warn = function(msg, ...)
  M.notify(msg, vim.log.levels.WARN, ...)
end

M.info = function(msg, ...)
  M.notify(msg, vim.log.levels.INFO, ...)
end

return M
