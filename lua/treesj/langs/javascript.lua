local u = require('treesj.langs.utils')

return {
  object = u.set_preset_for_dict(),
  array = u.set_preset_for_list(),
  formal_parameters = u.set_preset_for_args(),
  arguments = u.set_preset_for_args(),
  named_imports = u.set_preset_for_dict(),
  export_clause = u.set_preset_for_dict(),
  statement_block = u.set_preset_for_statement({
    join = {
      no_insert_if = {
        'function_declaration',
        'try_statement',
        'if_statement',
      },
    },
  }),
  lexical_declaration = {
    target_nodes = { 'array', 'object' },
  },
  variable_declaration = {
    target_nodes = { 'array', 'object' },
  },
  assignment_expression = {
    target_nodes = { 'array', 'object' },
  },
  try_statement = {
    target_nodes = {
      'statement_block',
    },
  },
  function_declaration = {
    target_nodes = {
      'statement_block',
    },
  },
  ['function'] = {
    target_nodes = {
      'statement_block',
    },
  },
  catch_clause = {
    target_nodes = {
      'statement_block',
    },
  },
  finally_clause = {
    target_nodes = {
      'statement_block',
    },
  },
  export_statement = {
    target_nodes = { 'export_clause', 'object' },
  },
  import_statement = {
    target_nodes = { 'named_imports', 'object' },
  },
  if_statement = {
    target_nodes = {
      'statement_block',
      'object',
    },
  },
}
