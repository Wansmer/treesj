local lang_utils = require('treesj.langs.utils')

return {
  literal_value = lang_utils.set_preset_for_list(),
  parameter_list = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  argument_list = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  block = lang_utils.set_preset_for_statement({
    join = {
      no_insert_if = {
        lang_utils.helpers.if_penultimate,
      },
    },
  }),
  interface_type = lang_utils.set_preset_for_statement({
    both = {
      shrink_node = { from = '{', to = '}' },
    },
    join = {
      no_insert_if = {
        lang_utils.helpers.if_penultimate,
      },
    },
  }),
  import_spec = lang_utils.set_preset_for_args({
    both = {
      enable = function(tsn)
        return tsn:parent():type() ~= 'import_spec_list'
      end,
    },
    split = {
      format_tree = function(tsj)
        tsj:wrap({ left = '(', right = ')' })
      end,
    },
  }),
  import_spec_list = lang_utils.set_preset_for_args({
    join = {
      enable = function(tsn)
        return tsn:named_child_count() < 2
      end,
      format_tree = function(tsj)
        tsj:remove_child({ '(', ')' })
      end,
    },
  }),
  import_declaration = { target_nodes = { 'import_spec', 'import_spec_list' } },
  -- const_declaration = { target_nodes = { 'const_spec' } },
  function_declaration = {
    target_nodes = { 'block' },
  },
  if_statement = {
    target_nodes = { 'block' },
  },
  short_var_declaration = { target_nodes = { 'literal_value' } },
  var_declaration = { target_nodes = { 'literal_value' } },
}
