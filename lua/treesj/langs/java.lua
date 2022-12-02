local u = require('treesj.langs.utils')

return {
  argument_list = u.set_preset_for_args(),
  formal_parameters = u.set_preset_for_args(),
  block = u.set_preset_for_statement(),
  constructor_body = u.set_preset_for_statement(),
  array_initializer = u.set_preset_for_list(),
  annotation_argument_list = u.set_preset_for_args(),
  enum_body = u.set_preset_for_dict(),
  enum_declaration = {
    target_nodes = { 'enum_body' },
  },
  if_statement = {
    target_nodes = { 'block' },
  },
  annotation = {
    target_nodes = { 'annotation_argument_list' },
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
