local lang_utils = require('treesj.langs.utils')

return {
  list = {
    both = {
      separator = ',',
      last_separator = false,
    },
    split = {
      -- Maintain necessary whitespace: https://github.com/Wansmer/treesj/discussions/163
      format_tree = function(tsj)
        local len = tsj:child(1):range()[2] -- index of first character of first node
        for child in tsj:iter_children() do
          if not (child:is_first() or child:is_omit()) then
            local indent = not child:is_last()
                and (' '):rep(len + vim.fn.shiftwidth())
              or (' '):rep(len)
            child:update_text(indent .. child:text())
          end
        end
      end,
    },
  },
}
