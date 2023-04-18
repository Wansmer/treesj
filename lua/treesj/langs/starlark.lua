local u = require('treesj.langs.utils')

-- Copy of `python.lua`
-- As starlark is syntactically equivalent.
-- With only small modifications:
--   * sets do not exist.
--   * function decorators do not exist.
--   * the raise keyword does not exist.

local no_space_in_brackets = u.set_preset_for_list({
  join = {
    space_in_brackets = false,
  },
})

return {
  dictionary = no_space_in_brackets,
  list = no_space_in_brackets,
  tuple = u.set_preset_for_list({
    join = {
      space_in_brackets = false,
      last_separator = true,
    },
  }),
  argument_list = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  parenthesized_expression = u.set_preset_for_args({}),
  list_comprehension = u.set_preset_for_args(),
  dictionary_comprehension = u.set_preset_for_args(),
  assignment = {
    target_nodes = {
      'tuple',
      'list',
      'dictionary',
      'argument_list',
      'list_comprehension',
      'dictionary_comprehension',
    },
  },
  call = {
    target_nodes = {
      'argument_list',
    },
  },
}
