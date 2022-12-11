local u = require('treesj.langs.utils')

return {
  field_declaration_list = u.set_preset_for_dict(),
  declaration_list = u.set_preset_for_statement(),
  field_initializer_list = u.set_preset_for_dict(),
  struct_pattern = u.set_preset_for_dict({
    both = {
      omit = { '{' },
    },
  }),
  parameters = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  arguments = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  tuple_type = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  enum_variant_list = u.set_preset_for_list(),
  tuple_expression = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  block = u.set_preset_for_statement({
    join = {
      no_insert_if = { u.no_insert.if_penultimate },
    },
  }),
  use_list = u.set_preset_for_list(),
  array_expression = u.set_preset_for_list(),
  let_declaration = {
    target_nodes = {
      'field_declaration_list',
      'field_initializer_list',
      'array_expression',
    },
  },
  function_item = {
    target_nodes = {
      'parameters',
    },
  },
  enum_item = {
    target_nodes = {
      'enum_variant_list',
    },
  },
  use_declaration = {
    target_nodes = {
      'use_list',
    },
  },
  trait_item = {
    target_nodes = {
      'declaration_list',
    },
  },
}
