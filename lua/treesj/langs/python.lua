local u = require('treesj.langs.utils')
local function imitate_tsn(tsn, parent, pos, text)
  text = text or ''

  local imitator = {}
  imitator.__index = imitator
  local sr, sc, er, ec
  if tsn then
    sr, sc, er, ec = tsn:range()
  elseif pos == 'first' then
    sr, sc = parent:range()
    er, ec = sr, sc
  elseif pos == 'last' then
    _, _, er, ec = parent:range()
    sr, sc = er, ec
  end

  function imitator:range()
    if pos == 'first' then
      return er, ec, er, ec
    else
      return sr, sc, sr, sc
    end
  end

  function imitator:type()
    return 'imitator'
  end

  function imitator:text()
    return text
  end

  return imitator
end

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
  argument_list = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  parenthesized_expression = u.set_preset_for_args({}),
  list_comprehension = u.set_preset_for_args(),
  set_comprehension = u.set_preset_for_args(),
  dictionary_comprehension = u.set_preset_for_args(),
  import_from_statement = u.set_preset_for_args({
    both = {
      omit = {
        u.omit.if_second,
        'import',
        function(tsj)
          return tsj:prev() and (tsj:prev():type() == 'import')
        end,
      },
    },
    split = {
      lifecycle = {
        collect_child = function(children, p)
          local res = {}
          for i, child in ipairs(children) do
            if child:type() == 'import' then
              table.insert(res, child)
              table.insert( res, imitate_tsn(child, child:parent(), 'first', ' ('))
            elseif i == #children then
              table.insert(res, child)
              table.insert( res, imitate_tsn(child, child:parent(), 'last', ')'))
            else
              table.insert(res, child)
            end
          end
          return res
        end,
      },
    },
    join = {
      lifecycle = {
        collect_child = function(children, p)
          p.non_bracket_node = true
          local remove = { '(', ')' }
          return vim.tbl_filter(function(tsn)
            return not vim.tbl_contains(remove, tsn:type())
          end, children)
        end,
      }
    }
  }),
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
