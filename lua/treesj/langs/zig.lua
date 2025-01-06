local lang_utils = require('treesj.langs.utils')

return {
  parameters = lang_utils.set_preset_for_args({
    split = {
      last_separator = true,
    },
  }),
  arguments = lang_utils.set_preset_for_args(),
  initializer_list = lang_utils.set_preset_for_list(),
  struct_declaration = lang_utils.set_preset_for_list({
    both = {
      omit = { '{' },
    },
  }),
  enum_declaration = lang_utils.set_preset_for_list({
    both = {
      omit = { '{' },
    },
  }),
  call_expression = lang_utils.set_preset_for_args({
    both = {
      omit = { '(' },
    },
    join = {
      format_resulted_lines = function(lines)
        lines[3] = lines[3]:gsub('^%s+', '')
        return lines
      end,
    },
    split = {
      last_separator = true,
      format_resulted_lines = function(lines)
        lines[1] = lines[1]:gsub('%(,$', '(')
        return lines
      end,
    },
  }),
}
