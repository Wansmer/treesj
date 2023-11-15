local lang_utils = require('treesj.langs.utils')

return {
  list_expression = lang_utils.set_preset_for_non_bracket({
    both = {
      last_separator = false,
    },
    split = {
      separator = ',',
      omit = {
        '=>',
        function(child)
          local prev = child:prev()
          return prev and prev:type() == '=>'
        end,
      },
    },
    join = {
      space_in_brackets = false,
    },
  }),
  anonymous_array_expression = { target_nodes = { 'list_expression' } },
  anonymous_hash_expression = { target_nodes = { 'list_expression' } },
  block = lang_utils.set_preset_for_statement({
    both = {
      omit = { 'semi_colon' },
    },
  }),
  variable_declaration = {
    target_nodes = { 'array', 'array_ref', 'hash_ref' },
  },
  array = lang_utils.set_preset_for_args({ -- Not relevant. Left for compatibility with previous versions of the parser
    split = {
      omit = {
        '=>',
        function(child)
          local prev = child:prev()
          return prev and prev:type() == '=>'
        end,
      },
    },
  }),
  hash_ref = lang_utils.set_preset_for_dict({ -- Not relevant. Left for compatibility with previous versions of the parser
    join = {
      space_in_brackets = false,
    },
  }),
  array_ref = lang_utils.set_preset_for_dict({ -- Not relevant. Left for compatibility with previous versions of the parser
    join = {
      space_in_brackets = false,
    },
  }),
}
