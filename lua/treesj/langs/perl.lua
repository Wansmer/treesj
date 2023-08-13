local lang_utils = require('treesj.langs.utils')

return {
  array = lang_utils.set_preset_for_args({
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
  hash_ref = lang_utils.set_preset_for_dict({
    join = {
      space_in_brackets = false,
    },
  }),
  array_ref = lang_utils.set_preset_for_dict({
    join = {
      space_in_brackets = false,
    },
  }),
  block = lang_utils.set_preset_for_statement({
    both = {
      omit = { 'semi_colon' },
    },
  }),
}
