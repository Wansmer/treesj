local u = require('treesj.langs.utils')
local ts = require('treesj.langs.typescript')

return u.merge_preset(ts, {
  jsx_opening_element = u.set_default_preset({
    both = {
      omit = { 'identifier' },
    },
  }),
  jsx_element = u.set_default_preset({
    join = {
      space_separator = 0,
    },
  }),
  jsx_self_closing_element = u.set_default_preset({
    both = {
      omit = { 'identifier', '>' },
      no_format_with = {},
    },
  }),
})
