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
    join = {
      force_insert = ';',
      no_insert_if = {
        lang_utils.no_insert.if_penultimate,
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
}
