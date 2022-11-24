local u = require('treesj.langs.utils')

return {
  jsx_opening_element = u.set_default_preset({
    both = {
      omit = { 'identifier' },
    },
  }),
  jsx_self_closing_element = u.set_default_preset({
    both = {
      omit = { 'identifier', '>' },
      no_format_with = {},
    },
  }),
}
