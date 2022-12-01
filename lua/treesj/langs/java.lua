local u = require('treesj.langs.utils')

return {
  argument_list = u.set_preset_for_args(),
  formal_parameters = u.set_preset_for_args(),
  block = u.set_preset_for_statement(),
  constructor_body = u.set_preset_for_statement(),
  array_initializer = u.set_preset_for_list(),
  if_statement = {
    target_nodes = { 'block' },
  },
  method_declaration = {
    target_nodes = { 'block' },
  },
  variable_declarator = {
    target_nodes = { 'array_initializer' },
  },
  constructor_declaration = {
    target_nodes = { 'constructor_body' },
  },
}
