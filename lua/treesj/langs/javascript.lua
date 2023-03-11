local lang_utils = require('treesj.langs.utils')

return {
  object = lang_utils.set_preset_for_dict(),
  object_pattern = lang_utils.set_preset_for_dict(),
  array = lang_utils.set_preset_for_list(),
  array_pattern = lang_utils.set_preset_for_list(),
  formal_parameters = lang_utils.set_preset_for_args(),
  arguments = lang_utils.set_preset_for_args(),
  named_imports = lang_utils.set_preset_for_dict(),
  export_clause = lang_utils.set_preset_for_dict(),
  statement_block = lang_utils.set_preset_for_statement({
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
  pair = {
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
  jsx_opening_element = lang_utils.set_default_preset({
    both = {
      omit = { 'identifier', 'nested_identifier' },
    },
  }),
  jsx_element = lang_utils.set_default_preset({
    join = {
      space_separator = false,
    },
  }),
  jsx_self_closing_element = lang_utils.set_default_preset({
    both = {
      omit = { 'identifier', 'nested_identifier', '>' },
      no_format_with = {},
    },
  }),
}
