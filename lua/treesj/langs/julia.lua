local lang_utils = require('treesj.langs.utils')

return {
  argument_list = lang_utils.set_preset_for_args({
    split = { last_separator = true },
  }),
  vector_expression = lang_utils.set_preset_for_list({
    join = { space_in_brackets = false },
  }),
  matrix_expression = lang_utils.set_preset_for_statement({
    join = {
      space_in_brackets = false,
      no_insert_if = { lang_utils.helpers.if_penultimate },
    },
    split = {
      format_tree = function(tsj)
        tsj:remove_child(';')
      end,
    },
  }),
  tuple_expression = lang_utils.set_preset_for_list({
    join = { space_in_brackets = false },
  }),
  comprehension_expression = lang_utils.set_preset_for_list({
    both = {
      separator = '',
    },
    join = {
      space_in_brackets = false,
    },
  }),
  call_expression = { target_nodes = { 'argument_list' } },
  using_statement = lang_utils.set_preset_for_non_bracket({
    both = {
      omit = { lang_utils.helpers.if_second },
    },
  }),
}
