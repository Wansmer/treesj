local u = require('treesj.langs.utils')

local no_space_in_brackets = u.set_preset_for_list({
  join = {
    space_in_brackets = false,
  },
})

return {
  dictionary = no_space_in_brackets,
  list = no_space_in_brackets,
  set = no_space_in_brackets,
  tuple = no_space_in_brackets,
  argument_list = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  parenthesized_expression = u.set_preset_for_args({}),
  list_comprehension = u.set_preset_for_args(),
  set_comprehension = u.set_preset_for_args(),
  assignment = {
    target_nodes = {
      'tuple',
      'list',
      'dictionary',
      'set',
    },
  },
}
