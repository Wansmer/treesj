local lang_utils = require('treesj.langs.utils')

return {
  start_tag = lang_utils.set_default_preset({
    both = {
      omit = { 'tag_name' },
    },
  }),
  self_closing_tag = lang_utils.set_default_preset({
    both = {
      omit = { 'tag_name' },
      no_format_with = {},
    },
  }),
  element = lang_utils.set_default_preset({
    join = {
      space_separator = false,
    },
  }),
}
