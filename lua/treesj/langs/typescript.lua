local u = require('treesj.langs.utils')
local js = require('treesj.langs.javascript')

return u.merge_preset(js, {
  object_type = u.set_preset_for_dict({
    both = { separator = ';', last_separator = true },
  }),
  object_pattern = u.set_preset_for_dict(),
  tuple_type = u.set_preset_for_dict(),
  enum_body = u.set_preset_for_dict(),
  type_parameters = u.set_preset_for_args({
    split = { last_separator = true },
    join = { space_in_brackets = false },
  }),
  type_arguments = u.set_preset_for_args({
    split = { last_separator = true },
    join = { space_in_brackets = false },
  }),
  ambient_declaration = {
    target_nodes = { 'object_type', 'statement_block' },
  },
  export_statement = {
    target_nodes = { 'export_clause', 'object_type', 'statement_block' },
  },
  lexical_declaration = {
    target_nodes = { 'object_type', 'statement_block' },
  },
  type_alias_declaration = {
    target_nodes = {
      'tuple_type',
      'object',
      'array',
      'object_type',
      'statement_block',
    },
  },
  enum_declaration = {
    target_nodes = { 'enum_body' },
  },
})
