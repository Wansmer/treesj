local lang_utils = require('treesj.langs.utils')
local c = require('treesj.langs.c')

return lang_utils.merge_preset(c, {
  template_argument_list = lang_utils.set_preset_for_args(),
  template_parameter_list = lang_utils.set_preset_for_args(),
  template_declaration = { target_nodes = { 'template_parameter_list' } },
  template_type = { target_nodes = { 'template_argument_list' } },
})
