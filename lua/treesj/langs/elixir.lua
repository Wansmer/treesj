local lang_utils = require('treesj.langs.utils')

return {
  list = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false
    },
    split = {
      recursive = false,
      last_separator = false,
    },
  }),
  map = {
    target_nodes = { 'map_content', 'keywords' },
  },
  map_content = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
    },
    split = {
      last_separator = false,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  keywords = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
    },
    split = {
      last_separator = false,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  arguments = lang_utils.set_preset_for_args(),
  tuple = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false
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
