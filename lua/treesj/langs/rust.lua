local lang_utils = require('treesj.langs.utils')

return {
  field_declaration_list = lang_utils.set_preset_for_dict(),
  declaration_list = lang_utils.set_preset_for_statement(),
  field_initializer_list = lang_utils.set_preset_for_dict(),
  struct_pattern = lang_utils.set_preset_for_dict({
    both = {
      omit = { '{' },
    },
  }),
  parameters = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  arguments = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  tuple_type = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  enum_variant_list = lang_utils.set_preset_for_list(),
  tuple_expression = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  block = lang_utils.set_preset_for_statement({
    join = {
      no_insert_if = { lang_utils.helpers.if_penultimate },
      format_tree = function(tsj)
        local node = tsj:tsnode()
        local parents = { 'match_arm', 'closure_expression' }
        local has_parent = vim.tbl_contains(parents, node:parent():type())
        if has_parent and node:named_child_count() == 1 then
          tsj:remove_child({ '{', '}' })
        end
      end,
    },
  }),
  value = lang_utils.set_preset_for_statement({
    split = {
      format_tree = function(tsj)
        if tsj:type() ~= 'block' then
          tsj:wrap({ left = '{', right = '}' })
        end
      end,
    },
    join = {
      no_insert_if = { lang_utils.helpers.if_penultimate },
      format_tree = function(tsj)
        local node = tsj:tsnode()
        local parents = { 'match_arm', 'closure_expression' }
        local has_parent = vim.tbl_contains(parents, node:parent():type())
        if has_parent and node:named_child_count() == 1 then
          tsj:remove_child({ '{', '}' })
        end
      end,
    },
  }),
  match_arm = {
    target_nodes = { 'value' },
  },
  closure_expression = {
    target_nodes = { ['body'] = 'value' },
  },
  use_list = lang_utils.set_preset_for_list(),
  array_expression = lang_utils.set_preset_for_list(),
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
