local utils = require('treesj.langs.utils')

return utils.merge_preset(require('treesj.langs.c'), {
  template_argument_list = utils.set_preset_for_args(),
  template_parameter_list = utils.set_preset_for_args(),
  template_declaration = { target_nodes = { 'template_parameter_list' } },
  template_type = { target_nodes = { 'template_argument_list' } },
})
