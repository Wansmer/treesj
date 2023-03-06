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
      foreach = function(child)
        local text = child:text()
        if child:is_framing() and type(text) == 'string' then
          local replace = { ['{'] = 'do', ['}'] = 'end' }
          if replace[text] then
            child:update_text(replace[text])
          end
        end
      end,
    },
  }),
  do_block = u.set_preset_for_dict({
    join = {
      separator = '',
      recursive = false,
      foreach = function(child)
        local text = child:text()
        if child:is_framing() and type(text) == 'string' then
          local replace = { ['do'] = '{', ['end'] = '}' }
          if replace[text] then
            child:update_text(replace[text])
          end
        end
      end,
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
