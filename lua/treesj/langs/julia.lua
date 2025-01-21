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
    join = {
      space_in_brackets = false,
      format_tree = function(tsj)
        if
          tsj:tsnode():parent():type() == 'assignment'
          -- Check if the tuple_expression is the left side in the assignment
          and tsj:tsnode():parent():child(0):equal(tsj:tsnode())
        then
          tsj:remove_child({ '(', ')' })
          tsj:child(-1):update_text(' ' .. tsj:child(-1):text())
        end
      end,
    },
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
  open_tuple = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
      format_tree = function(tsj)
        tsj:create_child({ text = '(' }, 1)
        tsj:create_child({ text = ')' }, #tsj:children() + 1)
        local penult = tsj:child(-2)
        penult:update_text(penult:text() .. ',')
      end,
    },
    join = {
      disable = true,
    },
  }),
}
