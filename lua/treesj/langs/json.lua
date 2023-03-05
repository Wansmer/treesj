local u = require('treesj.langs.utils')

return {
  object = u.set_preset_for_dict({
    split = {
      last_separator = false,
    },
  }),
  array = u.set_preset_for_list({
    split = {
      last_separator = false,
    },
  }),
  pair = { target_nodes = { 'object', 'array' } }
}
