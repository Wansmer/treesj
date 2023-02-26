local u = require('treesj.langs.utils')

return {
  list_expression = u.set_preset_for_list({
    both = {
      separator = '',
    }
  }),
  attrset_expression = u.set_preset_for_dict({
    both = {
      separator = ';',
      last_separator = true,
    },
  }),
  formals = u.set_preset_for_args({
    join = {
      space_in_brackets = true,
    },
  }),
  let_expression = u.set_preset_for_non_bracket(),
}
