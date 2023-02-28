local u = require('treesj.langs.utils')

return {
  collection_literal = u.set_default_preset({
    both = {
      separator = ',',
    },
  }),
  value_arguments = u.set_default_preset({
    both = {
      separator = ',',
    },
  }),
  statements = u.set_preset_for_non_bracket({
    join = {
      force_insert = ';',
      no_insert_if = {
        u.no_insert.if_penultimate,
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
