local u = require('treesj.langs.utils')
local api = require('treesj.api')

return {
  array = u.set_preset_for_list(),
  hash = u.set_preset_for_list(),
  method_parameters = u.set_preset_for_args(),
  argument_list = u.set_preset_for_args({
    both = {
      enable = function(tsn)
        return tsn:parent():type() ~= 'return'
      end,
    },
  }),
  block = u.set_preset_for_dict({
    join = {
      separator = '',
      recursive = false,
      format_tree = function(tsj)
        if tsj:has_children({ 'do', 'end' }) then
          tsj:child('do'):update_text('{')
          tsj:child('end'):update_text('}')
        end
      end,
    },
    split = {
      omit = { 'block_parameters' },
      separator = '',
      format_tree = function(tsj)
        if tsj:has_children({ '{', '}' }) then
          tsj:child('{'):update_text('do')
          tsj:child('}'):update_text('end')
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
          if else_:has_to_format() then
            local text = else_:child(1):text()
            else_:child(1):update_text(text:gsub('^else', ':'))
          else
            local text = else_:text()
            else_:update_text(text:gsub('^else', ':'))
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
      format_tree = function(tsj)
        local children = tsj:children()
        table.insert(children, tsj:create_child({ text = 'end', type = 'end' }))
        tsj:child('?'):update_text('if ')
        tsj:child(':'):update_text('else')
        local first, second = tsj:child(1), tsj:child(2)
        children[1] = second
        children[2] = first
        tsj:update_children(children)
      end,
      format_resulted_lines = function(lines)
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
      format_tree = function(tsj)
        tsj:create_child({ type = 'then', text = 'then' }, -1)
      end,
    },
    split = {
      last_indent = 'inner',
      format_tree = function(tsj)
        if tsj:has_children({ 'then' }) then
          local text = tsj:child('then'):text()
          tsj:child('then'):update_text(text:gsub('then%s', ''))
        end
      end,
    },
  }),
  right = u.set_default_preset({
    both = {
      enable = function(tsn)
        return not (tsn:type() == 'begin' and tsn:named_child_count() > 1)
      end,
    },
    split = {
      format_tree = function(tsj)
        tsj:wrap({ left = 'begin', right = 'end' })
      end,
    },
    join = {
      format_tree = function(tsj)
        tsj:remove_child({ 'begin', 'end' })
      end,
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
