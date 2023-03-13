local lang_utils = require('treesj.langs.utils')

return {
  object = lang_utils.set_preset_for_dict({
    split = {
      last_separator = false,
    },
  }),
  array = lang_utils.set_preset_for_list({
    split = {
      last_separator = false,
    },
  }),
  pair = { target_nodes = { 'object', 'array' } },
}
