local u = require('treesj.langs.utils')

return {
  table_constructor = u.set_preset_for_dict({
    -- split = {
    --   recursive = true,
    -- },
  }),
  arguments = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  block = u.set_preset_for_non_bracket({
    -- split = {
    --   recursive = true,
    --   recursive_ignore = { 'arguments', 'parameters' },
    -- },
  }),
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
