local langs = require('treesj.langs')
local lu = require('treesj.langs.utils')

local M = {}

---User options for `treesj`
---@class UserOpts
---@field use_default_keymaps boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
---@field check_syntax_error boolean Node with syntax error will not be formatted
---@field max_join_length number If line after join will be longer than max value, node will not be formatted
---@field cursor_behavior 'hold'|'start'|'end'
---@field notify boolean Notify about possible problems or not
---@field langs table Presets for languages
---@field dot_repeat boolean Use `dot` for repeat action
---@field on_error fun(err_text: string, level: number, ...)
local DEFAULT_SETTINGS = {
  ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,
  ---@type boolean Node with syntax error will not be formatted
  check_syntax_error = true,
  ---If line after join will be longer than max value,
  ---@type number If line after join will be longer than max value, node will not be formatted
  max_join_length = 120,
  ---Cursor behavior:
  ---hold - cursor follows the node/place on which it was called
  ---start - cursor jumps to the first symbol of the node being formatted
  ---end - cursor jumps to the last symbol of the node being formatted
  ---@type 'hold'|'start'|'end'
  cursor_behavior = 'hold',
  ---@type boolean Notify about possible problems or not
  notify = true,
  ---@type table Presets for languages
  langs = lu._prepare_presets(langs.presets),
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...)
  on_error = nil,
}

local commands = {
  {
    name = 'TSJToggle',
    desc = 'Split or Join code block with autodetect',
    func = 'toggle',
    keys = '<space>m',
    mode = 'n',
  },
  {
    name = 'TSJSplit',
    desc = 'Split code block',
    func = 'split',
    keys = '<space>s',
    mode = 'n',
  },
  {
    name = 'TSJJoin',
    desc = 'Join code block',
    func = 'join',
    keys = '<space>j',
    mode = 'n',
  },
}

M.settings = DEFAULT_SETTINGS

local function merge_settings(default_settings, opts)
  opts = opts or {}

  if opts.langs then
    for lang, presets in pairs(opts.langs) do
      for node, preset in pairs(presets) do
        local info = { lang = lang, node = node, mode = 'both' }
        presets[node] = lu._premerge(preset, info)
      end
      opts.langs[lang] = presets
    end
  end

  local settings = vim.tbl_deep_extend('force', default_settings, opts)
  settings.langs = lu._prepare_presets(settings.langs)
  settings.langs = lu._skip_disabled(settings.langs)
  return settings
end

M._create_commands = function()
  local treesj = require('treesj')
  for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd.name, function()
      treesj[cmd.func]()
    end, { desc = cmd.desc })
  end
end

M._set_default_keymaps = function()
  if M.settings and M.settings.use_default_keymaps then
    local treesj = require('treesj')
    for _, cmd in ipairs(commands) do
      vim.keymap.set(cmd.mode, cmd.keys, treesj[cmd.func], { desc = cmd.desc })
    end
  end
end

---@param opts UserOpts
M._update_settings = function(opts)
  M.settings = merge_settings(M.settings, opts)
end

return M
