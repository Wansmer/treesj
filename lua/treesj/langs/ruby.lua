local u = require('treesj.langs.utils')

return {
  array = u.set_preset_for_list(),
  hash = u.set_preset_for_list(),
  method_parameters = u.set_preset_for_args(),
  argument_list = u.set_preset_for_args(),
  block = u.set_preset_for_dict({
    split = {
      omit = { 'block_parameters' },
      separator = '',
      lifecycle = {
        after_build_tree = function(children, _, _)
          for _, child in ipairs(table) do
            print('Child type:', child:type())
          end
          return u.helper.replacer(children, { ['{'] = 'do', ['}'] = 'end' })
        end,
      },
    },
  }),
  do_block = u.set_preset_for_dict({
    join = {
      separator = '',
      recursive = false,
      lifecycle = {
        after_build_tree = function(children)
          local replace = { ['do'] = '{', ['end'] = '}' }
          return u.helper.replacer(children, replace)
        end,
      },
    },
  }),
  string_array = u.set_preset_for_list({
    split = {
      last_separator = false,
    },
  }),
  body_statement = u.set_preset_for_non_bracket({
    join = {
      force_insert = ';',
      no_insert_if = {
        u.no_insert.if_penultimate,
      },
    },
  }),
  method = {
    target_nodes = { 'body_statement' },
  },
  assignment = {
    target_nodes = { 'array', 'hash' },
  },
  call = {
    target_nodes = { 'block', 'do_block' },
  },
}
