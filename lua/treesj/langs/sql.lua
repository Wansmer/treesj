local lang_utils = require('treesj.langs.utils')

return {
  column_definitions = lang_utils.set_preset_for_args(),
  ordered_columns = lang_utils.set_preset_for_args(),
  list = lang_utils.set_preset_for_args(),
  select_expression = {
    both = {
      separator = ',',
      last_separator = true,
    },
    split = {
      inner_indent = 'normal',
      format_resulted_lines = function(lines, tsn)
        local _, sc = tsn:range()
        for i, line in ipairs(lines) do
          if i > 1 then
            lines[i] = (' '):rep(sc) .. line
          end
        end
        return lines
      end,
    },
    join = {
      space_in_brackets = true,
    },
  },
}
