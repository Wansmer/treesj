local M = {}

local DEFAULT_PRESET = require('treesj.langs.default_preset')

---Return merged preset. Wrapper for tbl_deep_extend with 'force' mode
---@param base table Base preset
---@param override table Preset for override
---@return table
function M.merge_preset(base, override)
  return vim.tbl_deep_extend('force', base, override)
end

---Return function for updating preset (default preset + override)
---@param preset? table Preset (default preset by default)
---@return function
local function set_preset(preset)
  preset = preset or {}
  preset = M.merge_preset(DEFAULT_PRESET, preset)
  return function(override)
    override = override or {}
    return M.merge_preset(preset, override)
  end
end

---Convert list-like table to dict-like table
---@param tbl table
---@return table
local function convert_to_dict(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    if type(key) == 'number' then
      result[value] = value
    else
      result[key] = value
    end
  end
  return result
end

---Merge 'both' fielf to 'split' and 'join' if needed
---@param preset table
---@return table
function M._premerge(preset)
  if preset.disable then
    return { disable = preset.disable }
  end

  if preset.target_nodes and not vim.tbl_isempty(preset.target_nodes) then
    return { target_nodes = convert_to_dict(preset.target_nodes) }
  end

  local both = preset.both or {}
  local split = preset.split or {}
  local join = preset.join or {}

  return {
    split = vim.tbl_deep_extend('force', both, split),
    join = vim.tbl_deep_extend('force', both, join),
  }
end

---Add 'separator' and 'force_insert' to 'omit'
---@param preset table
---@return table
function M._update_omit(preset)
  if preset.split and preset.join then
    local omit =
      vim.fn.uniq(vim.list_extend(preset.split.omit, preset.join.omit))

    if preset.split.separator ~= '' then
      table.insert(omit, preset.split.separator)
    end

    if preset.join.force_insert ~= '' then
      table.insert(omit, preset.join.force_insert)
    end

    preset.split.omit = omit
    preset.join.omit = omit
  end
  return preset
end

---Add missing options to preset
---@param preset table
---@return table
function M._add_missing(preset)
  return vim.tbl_deep_extend('force', M._premerge(DEFAULT_PRESET), preset)
end

---Prepare presets
---@param languages table List of configured languages
---@return table
function M._prepare_presets(languages)
  for lang, presets in pairs(languages) do
    for node, preset in pairs(presets) do
      preset = M._premerge(preset)
      preset = M._add_missing(preset)
      preset = M._update_omit(preset)
      presets[node] = preset
    end
    languages[lang] = presets
  end
  return languages
end

local function filter_nodes(nodes)
  local result = {}
  for node, preset in pairs(nodes) do
    if not preset.disable then
      result[node] = preset
    end
  end
  return result
end

---Return langs list without disabled nodes
---@param languages table
---@return table
function M._skip_disabled(languages)
  for lang, presets in pairs(languages) do
    languages[lang] = filter_nodes(presets)
  end
  return languages
end

M.set_default_preset = set_preset()

M.set_preset_for_list = set_preset({
  both = {
    separator = ',',
  },
  split = {
    last_separator = true,
  },
  join = {
    space_in_brackets = true,
  },
})

M.set_preset_for_dict = set_preset({
  both = {
    separator = ',',
  },
  split = {
    last_separator = true,
  },
  join = {
    space_in_brackets = true,
  },
})

M.set_preset_for_statement = set_preset({
  join = {
    space_in_brackets = true,
    force_insert = ';',
  },
})

M.set_preset_for_args = set_preset({
  both = {
    separator = ',',
    last_separator = false,
  },
})

M.set_preset_for_non_bracket = set_preset({
  both = {
    non_bracket_node = true,
  },
  join = {
    space_in_brackets = true,
  },
})

local helpers = {}

function helpers.if_penultimate(child)
  local next = child:next()
  return next and next:is_last() or false
end

function helpers.if_second(child)
  local prev = child:prev()
  return prev and prev:is_first() or false
end

function helpers.by_index(i)
  return function(child)
    return child:parent() and child:parent():child(i) == child
  end
end

function helpers.has_parent(parent_type)
  return function(child)
    return child:parent() and child:parent():type() == parent_type
  end
end

function helpers.match(pattern)
  return function(child)
    local text = child:text()
    return type(text) == 'string' and text:match(pattern) or false
  end
end

M.omit = vim.tbl_extend('force', {}, helpers)
M.no_insert = vim.tbl_extend('force', {}, helpers)

return M
