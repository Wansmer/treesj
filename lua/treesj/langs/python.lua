local u = require('treesj.langs.utils')

local no_space_in_brackets = u.set_preset_for_list({
  join = {
    space_in_brackets = false,
  },
})

return {
  dictionary = no_space_in_brackets,
  list = no_space_in_brackets,
  set = no_space_in_brackets,
  tuple = u.set_preset_for_list({
    join = {
      space_in_brackets = false,
      last_separator = true,
    },
  }),
  import_from_statement = u.set_preset_for_args({
    both = {
      omit = { u.omit.if_second, 'import', ' (' },
    },
    split = {
      last_separator = true,
      format_tree = function(tsj)
        if not tsj:has_children({ '(', ')' }) then
          tsj:create_child({ text = ' (' }, 4)
          tsj:create_child({ text = ')' }, #tsj:children() + 1)
          local penult = tsj:child(-2)
          penult:update_text(penult:text() .. ',')
        end
      end,
    },
    join = {
      format_tree = function(tsj)
        tsj:remove_child({ '(', ')' })
      end,
    },
  }),
  argument_list = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  parenthesized_expression = u.set_preset_for_args({}),
  list_comprehension = u.set_preset_for_args(),
  set_comprehension = u.set_preset_for_args(),
  dictionary_comprehension = u.set_preset_for_args(),
  assignment = {
    target_nodes = {
      'tuple',
      'list',
      'dictionary',
      'set',
      'argument_list',
      'list_comprehension',
      'set_comprehension',
      'dictionary_comprehension',
    },
  },
  decorator = {
    target_nodes = {
      'argument_list',
    },
  },
  raise_statement = {
    target_nodes = {
      'argument_list',
    },
  },
  call = {
    target_nodes = {
      'argument_list',
    },
  },
}
