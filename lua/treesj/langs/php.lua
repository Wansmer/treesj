local u = require('treesj.langs.utils')

return {
  array_creation_expression = u.set_preset_for_dict({
    join = {
      space_in_brackets = false,
    },
  }),
  arguments = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  formal_parameters = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  compound_statement = u.set_preset_for_statement({
    join = {
      no_insert_if = {
        'function_definition',
        'if_statement',
        'try_statement',
      },
    },
  }),
  assignment_expression = {
    target_nodes = { 'array_creation_expression', 'arguments' },
  },
  if_statement = {
    target_nodes = { 'compound_statement' },
  },
  else_clause = {
    target_nodes = { 'compound_statement' },
  },
  try_statement = {
    target_nodes = { 'compound_statement' },
  },
  catch_clause = {
    target_nodes = { 'compound_statement' },
  },
  anonymous_function_creation_expression = {
    target_nodes = { 'compound_statement' },
  },
  function_definition = {
    target_nodes = { 'compound_statement' },
  },
  method_declaration = {
    target_nodes = { 'compound_statement' },
  },
  arrow_function = {
    target_nodes = { 'formal_parameters' },
  },
  function_call_expression = {
    target_nodes = { 'arguments' },
  },
  scoped_call_expression = {
    target_nodes = { 'arguments' },
  },
  member_call_expression = {
    target_nodes = { 'arguments' },
  },
  object_creation_expression = {
    target_nodes = { 'arguments' },
  },
}
