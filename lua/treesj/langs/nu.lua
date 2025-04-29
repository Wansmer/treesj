local lang_utils = require('treesj.langs.utils')

local DEFAULT_PRESET = require('treesj.langs.default_preset')

local M = {}

---Return function for updating preset (default preset + override)
---@param preset? table Preset (default preset by default)
---@return fun(override: table): table
local function set_preset(preset)
	preset = preset or {}
	preset = lang_utils.merge_preset(DEFAULT_PRESET, preset)
	return function(override)
		override = override or {}
		return lang_utils.merge_preset(preset, override)
	end
end

M.parameter_bracks = lang_utils.set_default_preset({
	split = {
		format_resulted_lines = function(lines)
			return vim.iter(lines):map(function(line)
				line = line:gsub(",$", "")
				return line
			end):totable()
		end,
	},
	join = {
		space_separator = true,
		space_in_brackets = true,
		force_insert = ',',
		no_insert_if = { lang_utils.helpers.if_penultimate },
	},
})

local set_preset_for_block = set_preset({
	both = {
		omit = { "parameter_pipes" },
	},
	join = {
		space_separator = true,
		space_in_brackets = true,
		force_insert = ';',
		no_insert_if = {
			"parameter_pipes",
			lang_utils.helpers.if_penultimate,
		},
	},
})

M.expr_parenthesized = set_preset_for_block({})
M.block = set_preset_for_block({
	split = {
		format_tree = function(tsj)
			tsj:remove_child(";")
		end,
	},
})
M.val_closure = set_preset_for_block({
	split = {
		format_tree = function(tsj)
			tsj:remove_child(";")
		end,
	},
})

local set_preset_for_list = set_preset({
	both = {
		non_bracket_node = true,
	},
	split = {
		last_separator = true,
	},
	join = {
		last_separator = false,
		space_in_brackets = false,
		force_insert = ',',
		no_insert_if = { lang_utils.helpers.if_penultimate },
	}
})

M.val_list = { target_nodes = { "list_body" } }
M.list_body = set_preset_for_list({})

M.val_record = { target_nodes = { "record_body" } }
M.record_body = set_preset_for_list({})

M.ctrl_match = set_preset_for_list({
	both = {
		non_bracket_node = true,
		shrink_node = { from = '{', to = '}' },
	},
	join = {
		space_in_brackets = true,
	}
})

M.pipeline = lang_utils.set_default_preset({
	join = {
		space_separator = false,
		--
		format_tree = function(tsj)
			for _, child in ipairs(tsj:children({ "|" })) do
				child:update_text(" | ")
			end
		end,
	},
	split = {
		inner_indent = "normal",
		last_indent = "normal",
		---@param tsj TreeSJ
		format_tree = function(tsj)
			tsj:remove_child("|")
			for idx, child in ipairs(tsj:children()) do
				if idx ~= 1 then
					child:update_text("| " .. child:text())
				end
			end
		end,
	},
})

return M
