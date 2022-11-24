local u = require('treesj.langs.utils')

return {
  array_creation_expression = u.set_preset_for_dict {
    join = {
      space_in_brackets = false,
    },
  },
  arguments = u.set_preset_for_args {
    join = {
      space_in_brackets = false,
    },
  },
  formal_parameters = u.set_preset_for_args(),
  compound_statement = u.set_preset_for_statement(),
  expression_statement = {
    target_nodes = { 'array_creation_expression' },
  },
}
