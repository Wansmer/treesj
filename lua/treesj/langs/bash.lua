local lang_utils = require('treesj.langs.utils')

local statement = lang_utils.set_preset_for_statement({
  join = {
    force_insert = ';',
  },
  split = {
    format_tree = function(tsj)
      tsj:remove_child(';')
    end,
  },
})

return {
  array = lang_utils.set_preset_for_list({
    both = {
      separator = '',
      last_separator = false,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  compound_statement = statement,
  do_group = statement,
  if_statement = vim.tbl_deep_extend('force', statement, {
    both = {
      enable = function(tsn)
        return not lang_utils.helpers.contains({
          'elif_clause',
          'else_clause',
        })(tsn)
      end,
      shrink_node = { from = 'then' },
    },
  }),
  variable_assignment = {
    target_nodes = { 'array' },
  },
  for_statement = {
    target_nodes = { 'do_group', 'compound_statement' },
  },
}
