local lang_utils = require('treesj.langs.utils')

return {
  array = lang_utils.set_preset_for_list({
    split = {
      last_separator = false,
    },
  }),
}
