local lang_utils = require('treesj.langs.utils')

return {
  collection_literal = lang_utils.set_default_preset({
    both = {
      separator = ',',
    },
  }),
  value_arguments = lang_utils.set_default_preset({
    both = {
      separator = ',',
    },
  }),
  statements = lang_utils.set_preset_for_non_bracket({
    split = {
      recursive_ignore = { 'value_arguments' },
    },
    join = {
      force_insert = ';',
      no_insert_if = {
        lang_utils.helpers.if_penultimate,
      },
    },
  }),
  lambda_literal = {
    target_nodes = {
      'statements',
    },
  },
  function_body = {
    target_nodes = {
      'statements',
    },
  },
  property_declaration = {
    target_nodes = {
      'collection_literal',
      'value_arguments',
    },
  },
  function_declaration = lang_utils.set_preset_for_args({
    both = {
      non_bracket_node = true,
      shrink_node = { from = '(', to = ')' },
    },
  }),
}
