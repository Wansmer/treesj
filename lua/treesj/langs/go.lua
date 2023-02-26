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
  import_spec = u.set_preset_for_args({
    both = {
      enable = function(tsn)
        return tsn:parent():type() ~= 'import_spec_list'
      end,
    },
    split = {
      non_bracket_node = true,
      add_framing_nodes = { left = ' (', right = ')' },
    },
  }),
  import_spec_list = u.set_preset_for_args({
    join = {
      enable = function(tsn)
        return tsn:named_child_count() < 2
      end,
      foreach = function(tsj)
        if tsj:is_framing() then
          tsj:_update_text('')
        end
      end,
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
