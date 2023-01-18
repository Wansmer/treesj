local langs = require('treesj.langs')
local lu = require('treesj.langs.utils')

local M = {}

local DEFAULT_SETTINGS = {
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,
  -- Node with syntax error will not be formatted
  check_syntax_error = true,
  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 120,
  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',
  -- Notify about possible problems or not
  notify = true,
  langs = lu._prepare_presets(langs.presets),
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
  -- TODO: rewrite
  if opts.langs then
    for lang, presets in pairs(opts.langs) do
      for node, preset in pairs(presets) do
        presets[node] = lu._premerge(preset)
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
    vim.api.nvim_create_user_command(
      cmd.name,
      treesj[cmd.func],
      { desc = cmd.desc }
    )
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

M._update_settings = function(opts)
  M.settings = merge_settings(M.settings, opts)
end

return M
