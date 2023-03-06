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
      omit = { u.omit.if_second, 'import', '(' },
    },
    split = {
      lifecycle = {
        before_build_tree = function(children, _, tsj)
          local up_children = {}
          children = vim.tbl_filter(function(child)
            local remove = { '(', ')' }
            return not vim.tbl_contains(remove, child:type())
          end, children)

          for i, child in ipairs(children) do
            if child:type() == 'import' then
              table.insert(up_children, child)
              table.insert(
                up_children,
                u.imitate_tsn(children[i + 1], tsj:tsnode(), 'last', '(')
              )
            elseif child == children[#children] then
              table.insert(up_children, child)
              table.insert(
                up_children,
                u.imitate_tsn(child, tsj:tsnode(), 'last', ')')
              )
            else
              table.insert(up_children, child)
            end
          end

          return up_children
        end,
      },
    },
    join = {
      lifecycle = {
        after_build_tree = function(children)
          for _, child in ipairs(children) do
            local brackets = { '(', ')' }
            if vim.tbl_contains(brackets, child:type()) then
              child:update_text('')
            end
          end
          return children
        end,
      },
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
