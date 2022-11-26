local treesj_utils = require('treesj.langs.utils')

return {
    parameters = treesj_utils.set_preset_for_args(),
    argument_list = treesj_utils.set_preset_for_args(),
    list = treesj_utils.set_preset_for_list(),
    set = treesj_utils.set_preset_for_list(),
    tuple = treesj_utils.set_preset_for_list(),
    dictionary = treesj_utils.set_preset_for_dict({ both = { last_separator = false }}),

    assignment = { target_nodes = { 'list', 'set', 'tuple', 'dictionary' } },
    call = { target_nodes = { 'argument_list' } },
}
