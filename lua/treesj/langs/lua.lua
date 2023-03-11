local lang_utils = require('treesj.langs.utils')

return {
  table_constructor = lang_utils.set_preset_for_dict(),
  arguments = lang_utils.set_preset_for_args(),
  parameters = lang_utils.set_preset_for_args(),
  block = lang_utils.set_preset_for_non_bracket(),
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
