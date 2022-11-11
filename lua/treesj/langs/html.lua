local u = require('treesj.langs.utils')

return {
  start_tag = u.set_default_preset({
    both = {
      omit = { 'tag_name' },
    },
  }),
  self_closing_tag = u.set_default_preset({
    both = {
      omit = { 'tag_name' },
      no_format_with = {},
    },
  }),
  element = u.set_default_preset({
    join = {
      space_separator = 0,
    },
  }),
}
