local u = require('treesj.langs.utils')

return {
  list_expression = u.set_preset_for_list({
    both = {
      separator = '',
    }
  }),
  attrset_expression = {
    target_nodes = { 'binding_set' },
  },
  binding_set = u.set_preset_for_dict({
    both = {
      non_bracket_node = true,
      separator = ';',
      last_separator = true,
    },
  }),
  formals = u.set_preset_for_args({
    both = {
      omit = { 'formal', 'ellipses' }
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
}
