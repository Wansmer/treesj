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
  -- block = u.set_preset_for_statement({
  --   join = {
  --     no_insert_if = { u.no_insert.if_penultimate },
  --   },
  -- }),
  use_list = u.set_preset_for_list(),
  array_expression = u.set_preset_for_list(),
  block = u.set_preset_for_statement({
    join = {
      no_insert_if = { u.no_insert.if_penultimate },
      filter = {
        function(tsn)
          if u.container.has_parent(tsn, 'match_arm') then
            local skip = { '{', '}' }
            return not vim.tbl_contains(skip, tsn:type())
          else
            return true
          end
        end,
      },
    },
  }),
  value = u.set_preset_for_statement({
    both = {
      non_bracket_node = false,
    },
    split = {
      add_framing_nodes = {
        left = '{',
        right = '}',
        mode = 'pack',
      },
    },
  }),
  match_arm = {
    target_nodes = { 'value' },
  },
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
