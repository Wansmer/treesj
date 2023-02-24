local u = require('treesj.langs.utils')

return {
  array = u.set_preset_for_list({
    split = {
      last_separator = false,
    },
  }),
}
