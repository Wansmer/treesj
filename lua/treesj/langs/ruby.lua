local u = require('treesj.langs.utils')
local api = require('treesj.api')

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
  if_modifier = u.set_default_preset({
    join = nil,
    split = {
      omit = { u.omit.if_second },
      format_tree = function(tsj)
        local if_node = tsj:child('if')
        local end_ = tsj:create_child({ text = 'end', type = 'end' })
        tsj:update_children({ if_node, if_node:next(), tsj:child(1), end_ })
      end,
    },
  }),
  ['if'] = u.set_default_preset({
    split = nil,
    join = {
      enable = function(tsn)
        local check = {
          tsn:field('consequence')[1],
          tsn:field('alternative')[1],
        }

        return api.every(check, function(el)
          return not el and true or el:named_child_count() == 1
        end)
      end,
      space_in_brackets = true,
      format_tree = function(tsj)
        if tsj:child('else') then
          local if_ = tsj:child('if')
          local else_ = tsj:child('else')
          if else_:children() then
            local text = else_:child(1):text()
            else_:child(1):update_text(text:gsub('^else', ':'))
          end
          if_:update_text('? ')
          tsj:update_children({ tsj:child(2), if_, tsj:child('then'), else_ })
        else
          local if_node = tsj:child('if')
          tsj:update_children({ tsj:child('then'), if_node, if_node:next() })
        end
      end,
    },
  }),
  conditional = u.set_default_preset({
    join = nil,
    split = {
      omit = { u.omit.if_second },
      lifecycle = {
        before_build_tree = function(children, _, tsj)
          table.insert(children, u.imitate_tsn(nil, tsj, 'last', 'end'))
          return children
        end,
        after_build_tree = function(children, preset, tsj)
          local replace = { ['?'] = 'if ', [':'] = 'else' }
          children = u.helper.replacer(children, replace)
          local first, second = children[1], children[2]
          children[1] = second
          children[2] = first
          return children
        end,
        before_text_insert = function(lines)
          return vim.tbl_map(function(line)
            if line:match('%s.else$') then
              -- TODO: create helper `unindent`
              local rgx = '^' .. (' '):rep(vim.fn.shiftwidth())
              return line:gsub(rgx, '')
            else
              return line
            end
          end, lines)
        end,
      },
    },
  }),
  when = u.set_default_preset({
    both = {
      omit = { u.omit.if_second },
    },
    join = {
      space_in_brackets = true,
      enable = function(tsn)
        return tsn:field('body')[1]:named_child_count() == 1
      end,
      lifecycle = {
        before_build_tree = function(children, _, tsj)
          table.insert(
            children,
            #children,
            u.imitate_tsn(children[#children], tsj, 'first', 'then')
          )
          return children
        end,
      },
    },
    split = {
      last_indent = 'inner',
      lifecycle = {
        after_build_tree = function(children)
          local then_ = u.helper.get_by_type(children, 'then')
          if then_ then
            local text = then_:text()
            then_:update_text(text:gsub('then%s', ''))
          end
          return children
        end,
      },
    },
  }),
  right = u.set_default_preset({
    both = {
      enable = function(tsn)
        if tsn:type() == 'begin' and tsn:named_child_count() > 1 then
          return false
        end
        return true
      end,
    },
    split = {
      add_framing_nodes = { left = 'begin', right = 'end', mode = 'pack' },
    },
    join = {
      lifecycle = {
        before_build_tree = function(children)
          return u.helper.remover(children, { 'begin', 'end' })
        end,
      },
    },
  }),
  operator_assignment = { target_nodes = { 'right' } },
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
