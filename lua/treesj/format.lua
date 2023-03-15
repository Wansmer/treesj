local notify = require('treesj.notify')
local search = require('treesj.search')
local TreeSJ = require('treesj.treesj')
local CHold = require('treesj.chold')
local tu = require('treesj.treesj.utils')
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

function M._format(mode, override)
  local start_node = ts_utils.get_node_at_cursor(0)
  if not start_node then
    notify.info(msg.no_detect_node)
    return
  end

  local found, tsn_data, node, p, sr, sc, er, ec, MODE, lang
  local viewed = {}

  -- If the node is marked as "disabled", continue searching from its parent.
  while true do
    found, tsn_data = pcall(search.get_configured_node, start_node)
    if not found then
      notify.warn(tsn_data)
      return
    end

    -- If the found node has already been rejected, then finish
    if vim.tbl_contains(viewed, tsn_data.tsnode) then
      notify.info(msg.node_is_disable, MODE, node:type())
      return
    end

    if override then
      tsn_data.preset = vim.tbl_deep_extend('force', tsn_data.preset, override)
    end

    node = tsn_data.tsnode
    p = tsn_data.preset
    lang = tsn_data.lang
    sr, sc, er, ec = search.range(node, p)
    MODE = mode or sr == er and SPLIT or JOIN
    p = p[MODE]

    local enable = p
      and (type(p.enable) == 'boolean' and p.enable or p.enable(node))

    if not enable then
      table.insert(viewed, node)
      start_node = node:parent()
    else
      -- Need to use a copy of the preset so that it can be updated on the fly
      tsn_data.preset = vim.tbl_deep_extend('force', {}, tsn_data.preset)
      break
    end
  end

  if p and not p.format_empty_node then
    if not p.non_bracket_node and tu.is_empty_node(node, p) then
      return
    end
  end

  if settings.check_syntax_error and node:has_error() then
    notify.warn(msg.contains_error, node:type(), MODE)
    return
  end

  if search.has_disabled_descendants(node, MODE, lang) then
    local no_format_with = p and vim.inspect(p.no_format_with) or ''
    notify.info(msg.no_format_with, MODE, node:type(), no_format_with)
    return
  end

  tsn_data.mode = MODE
  local treesj = TreeSJ.new(tsn_data)
  treesj:_build_tree()

  local ok_format, err = pcall(treesj._format, treesj)
  if not ok_format then
    notify.warn(err)
    return
  end

  local replacement = treesj:_get_lines()

  if MODE == JOIN and #replacement[1] > MAX_LENGTH then
    notify.info(msg.extra_longer:format(MAX_LENGTH))
    return
  end

  local cursor = CHold.new()
  cursor:compute(treesj, MODE)
  local new_cursor = cursor:get_cursor()

  local insert_ok, e =
    pcall(vim.api.nvim_buf_set_text, 0, sr, sc, er, ec, replacement)

  if not insert_ok then
    notify.warn(e)
    return
  end

  pcall(vim.api.nvim_win_set_cursor, 0, new_cursor)
end

return M
