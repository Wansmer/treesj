local treesj_utils = require('treesj.langs.utils')

return {
    parameter_list = treesj_utils.set_preset_for_args(),
    argument_list = treesj_utils.set_preset_for_args(),
    template_argument_list = treesj_utils.set_preset_for_args(),
    template_parameter_list = treesj_utils.set_preset_for_args(),
    initializer_list = treesj_utils.set_preset_for_list(),
    compound_statement = treesj_utils.set_preset_for_statement({
        both = {
            separator = ';',
            last_separator = true,
            no_format_with = { 'compound_statement' },
            recursive = false
        },
    }),

    if_statement = { target_nodes = { 'compound_statement' }},
    declaration = { target_nodes = { 'parameter_list', 'argument_list', 'initializer_list' } },
    call_expression = { target_nodes = { 'argument_list' }},
    template_declaration = { target_nodes = { 'template_parameter_list' }}
}
