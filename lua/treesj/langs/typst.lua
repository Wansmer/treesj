local lang_utils = require('treesj.langs.utils')

return {
  content = lang_utils.set_default_preset(),
  group = lang_utils.set_default_preset({
    both = {
      separator = ',',
      last_separator = true,
    },
    join = {
      last_separator = false,
    },
  }),
}
