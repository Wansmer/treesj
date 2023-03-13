local lang_utils = require('treesj.langs.utils')

return {
  list_expression = lang_utils.set_preset_for_list({
    both = {
      separator = '',
    },
  }),
  attrset_expression = {
    target_nodes = { 'binding_set' },
  },
  binding_set = lang_utils.set_preset_for_dict({
    both = {
      non_bracket_node = true,
      separator = '',
      force_insert = ';',
    },
  }),
  formals = lang_utils.set_preset_for_args({
    both = {
      omit = { 'formal', 'ellipses' },
    },
    split = {
      separator = '',
      inner_indent = 'normal',
    },
    join = {
      separator = ',',
      space_in_brackets = true,
    },
  }),
  let_expression = lang_utils.set_default_preset({
    both = {
      omit = { 'binding_set' },
    },
    split = {
      recursive = true,
      inner_indent = 'normal',
      last_indent = 'inner',
    },
    join = {
      space_in_brackets = true,
      space_separator = true,
    },
  }),
}
