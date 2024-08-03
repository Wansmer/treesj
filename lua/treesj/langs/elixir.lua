local lang_utils = require('treesj.langs.utils')

return {
  list = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false,
    },
    split = {
      recursive = false,
      last_separator = false,
    },
  }),
  map = { target_nodes = { 'map_content' } },
  map_content = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
    },
    split = {
      last_separator = false,
      format_tree = function(tsj)
        if tsj:has_children({ 'keywords' }) then
          tsj:update_preset(
            { recursive = true, recursive_ignore = { 'map' } },
            'split'
          )
          local keywords = tsj:child('keywords')
          keywords:update_preset({ inner_indent = 'normal' }, 'split')
        end
      end,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  keywords = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
      format_resulted_lines = function(lines)
        return vim.tbl_map(function(line)
          -- Replace ':%{' with ': %{'
          -- This happens when a keyword is pointing to a map like `foo` here:
          -- %{ foo: %{ inner: "value" } }
          if line:match(':%%{') then
            return line:gsub(':%%{', ': %%{')
          else
            return line
          end
        end, lines)
      end,
    },
    split = {
      inner_indent = 'inner',
      last_separator = false,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  arguments = lang_utils.set_preset_for_args(),
  tuple = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false,
    },
    split = {
      recursive = false,
      last_separator = false,
    },
  }),
  binary_operator = {
    target_nodes = { 'list', 'map', 'tuple' },
  },
}
