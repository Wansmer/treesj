local notify = require('treesj.notify')
local search = require('treesj.search')
local TreeSJ = require('treesj.treesj')
local NCHold = require('treesj.chold')
local u = require('treesj.utils')
local settings = require('treesj.settings').settings
local msg = notify.msg

local ok_ts_utils, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
if not ok_ts_utils then
  notify.warn(msg.ts_not_found)
end

local SPLIT = 'split'
local JOIN = 'join'
local MAX_LENGTH = settings.max_join_length

local M = {}

function M._format(mode)
  local start_node = ts_utils.get_node_at_cursor(0)
  if not start_node then
    notify.info(msg.no_detect_node)
    return
  end

  local found, node = pcall(search.get_configured_node, start_node)
  if not found then
    notify.warn(node)
    return
  end

  local sr, sc, er, ec = u.range(node)
  local MODE = mode or sr == er and SPLIT or JOIN
  local p = u.get_preset(node, MODE)

  if p and not p.format_empty_node then
    if not p.non_bracket_node and u.is_empty_node(node, p) then
      return
    end
  end

  if settings.check_syntax_error and node:has_error() then
    notify.warn(msg.contains_error, node:type(), MODE)
    return
  end

  if u.has_disabled_descendants(node, MODE) then
    local no_format_with = p and vim.inspect(p.no_format_with) or ''
    notify.info(msg.no_format_with, MODE, node:type(), no_format_with)
    return
  end

  local treesj = TreeSJ.new(node)
  treesj:build_tree()
  treesj[MODE](treesj)
  local replacement = treesj:get_lines()

  if MODE == JOIN and #replacement[1] > MAX_LENGTH then
    notify.info(msg.extra_longer:format(MAX_LENGTH))
    return
  end

  local cursor = NCHold.new()
  cursor:compute(treesj, MODE)
  local new_cursor = cursor:get_cursor()

  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, replacement)
  pcall(vim.api.nvim_win_set_cursor, 0, new_cursor)
end

return M
