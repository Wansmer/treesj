local u = require('treesj.langs.utils')

return {
  literal_value = u.set_preset_for_list(),
  parameter_list = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  argument_list = u.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  block = u.set_preset_for_statement({
    join = {
      no_insert_if = {
        u.no_insert.if_penultimate,
      },
    },
  }),
  function_declaration = {
    target_nodes = { 'block' },
  },
  if_statement = {
    target_nodes = { 'block' },
  },
  short_var_declaration = { target_nodes = { 'literal_value' } },
  var_declaration = { target_nodes = { 'literal_value' } },
}
