local lang_utils = require('treesj.langs.utils')

return {
  argument_list = lang_utils.set_preset_for_args(),
  parameter_list = lang_utils.set_preset_for_args(),
  initializer_expression = lang_utils.set_preset_for_list(),
  element_binding_expression = lang_utils.set_preset_for_list(),
  block = lang_utils.set_preset_for_statement(),
}
