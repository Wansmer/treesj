local lang_utils = require('treesj.langs.utils')

local split_recursive_ignore = {
  split = { recursive_ignore = { 'arguments', 'parameters' } },
}

return {
  table_constructor = lang_utils.set_preset_for_dict(split_recursive_ignore),
  arguments = lang_utils.set_preset_for_args(),
  parameters = lang_utils.set_preset_for_args(),
  block = lang_utils.set_preset_for_non_bracket(split_recursive_ignore),
  variable_declaration = {
    target_nodes = { 'table_constructor', 'block' },
  },
  assignment_statement = {
    target_nodes = { 'table_constructor', 'block' },
  },
  if_statement = { target_nodes = { 'block' } },
  else_statement = { target_nodes = { 'block' } },
  function_declaration = { target_nodes = { 'block' } },
  function_definition = { target_nodes = { 'block' } },
}
