local lang_utils = require('treesj.langs.utils')

local rec_ignore = { 'arguments', 'formal_parameters' }
local arrow_body_format_join = function(tsj)
  local parent = tsj:tsnode():parent():type()
  if parent == 'arrow_function' and tsj:tsnode():named_child_count() == 1 then
    tsj:remove_child({ '{', '}' })
    tsj:update_preset({ force_insert = '', space_in_brackets = false }, 'join')
    local ret = tsj:child('return_statement')

    if ret then
      if ret:has_to_format() then
        ret:remove_child({ 'return', ';' })
        local obj = ret:child('object')
        if obj then
          tsj:wrap({ left = '(', right = ')' }, 'inline')
        end
      else
        local text = ret:text():gsub('^return ', ''):gsub(';$', '')
        ret:update_text(text)
      end
    end
  end
end

return {
  object = lang_utils.set_preset_for_dict({
    split = { recursive_ignore = rec_ignore },
  }),
  object_pattern = lang_utils.set_preset_for_dict({
    both = { recursive_ignore = rec_ignore },
  }),
  array = lang_utils.set_preset_for_list({
    split = { recursive_ignore = rec_ignore },
  }),
  array_pattern = lang_utils.set_preset_for_list({
    split = { recursive_ignore = rec_ignore },
  }),
  formal_parameters = lang_utils.set_preset_for_args(),
  arguments = lang_utils.set_preset_for_args(),
  named_imports = lang_utils.set_preset_for_dict(),
  export_clause = lang_utils.set_preset_for_dict(),
  statement_block = lang_utils.set_preset_for_statement({
    split = {
      recursive_ignore = rec_ignore,
    },
    join = {
      no_insert_if = {
        'function_declaration',
        'try_statement',
        'if_statement',
      },
      format_tree = arrow_body_format_join,
    },
  }),
  body = lang_utils.set_preset_for_statement({
    split = {
      recursive_ignore = rec_ignore,
      format_tree = function(tsj)
        if tsj:type() ~= 'statement_block' then
          tsj:wrap({ left = '{', right = '}' })

          local ph = tsj:child('parenthesized_expression')
          local not_seq = ph and not ph:child('sequence_expression')

          if not_seq then
            if ph:will_be_formatted() then
              ph:remove_child({ '(', ')' })
            else
              local text = ph:text():gsub('^%(', ''):gsub('%)$', '')
              ph:update_text(text)
            end
          end

          local body = tsj:child(2)
          if body:will_be_formatted() then
            local set_return
            if body:has_preset('split') then
              set_return = body:child(1)
            else
              set_return = body:child(1):child(1)
            end
            set_return:update_text('return ' .. set_return:text())
          else
            body:update_text('return ' .. body:text())
          end
        end
      end,
    },
    join = {
      space_in_brackets = false,
      force_insert = '',
      format_tree = arrow_body_format_join,
    },
  }),
  arrow_function = { target_nodes = { 'body' } },
  lexical_declaration = {
    target_nodes = { 'array', 'object' },
  },
  pair = {
    target_nodes = { 'array', 'object' },
  },
  variable_declaration = {
    target_nodes = { 'array', 'object' },
  },
  assignment_expression = {
    target_nodes = { 'array', 'object' },
  },
  try_statement = {
    target_nodes = {
      'statement_block',
    },
  },
  function_declaration = {
    target_nodes = {
      'statement_block',
    },
  },
  ['function'] = {
    target_nodes = {
      'statement_block',
    },
  },
  catch_clause = {
    target_nodes = {
      'statement_block',
    },
  },
  finally_clause = {
    target_nodes = {
      'statement_block',
    },
  },
  export_statement = {
    target_nodes = { 'export_clause', 'object' },
  },
  import_statement = {
    target_nodes = { 'named_imports', 'object' },
  },
  if_statement = {
    target_nodes = {
      'statement_block',
      'object',
    },
  },
  jsx_opening_element = lang_utils.set_default_preset({
    both = {
      omit = { 'identifier', 'nested_identifier' },
    },
  }),
  jsx_element = lang_utils.set_default_preset({
    join = {
      space_separator = false,
    },
  }),
  jsx_self_closing_element = lang_utils.set_default_preset({
    both = {
      omit = { 'identifier', 'nested_identifier', '>' },
      no_format_with = {},
    },
  }),
}
