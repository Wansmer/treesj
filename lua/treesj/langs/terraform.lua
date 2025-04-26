local lang_utils = require('treesj.langs.utils')

return {
  tuple = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false,
    },
  }),
  object = lang_utils.set_preset_for_dict({
    split = {
      separator = '',
      format_tree = function(tsj)
        tsj:remove_child(',')
      end,
    },
    join = {
      space_in_brackets = false,
      force_insert = ',',
      no_insert_if = { lang_utils.helpers.if_penultimate },
    },
  }),
  function_call = {
    target_nodes = { 'function_arguments' },
  },
  function_arguments = lang_utils.set_preset_for_args({
    both = {
      non_bracket_node = true,
    },
    join = {
      recursive = true,
    },
    split = {
      last_separator = true,
    },
  }),
}
