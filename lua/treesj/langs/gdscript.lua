local lang_utils = require('treesj.langs.utils')

local no_space_in_brackets_list = lang_utils.set_preset_for_list({
  join = { space_in_brackets = false },
})
local no_space_in_brackets_dict = lang_utils.set_preset_for_dict({
  join = { space_in_brackets = false },
})

return {
  arguments = lang_utils.set_preset_for_args(),
  parameters = lang_utils.set_preset_for_args(),
  array = no_space_in_brackets_list,
  dictionary = no_space_in_brackets_dict,
  enumerator_list = no_space_in_brackets_dict,

  call = {
    target_nodes = { 'arguments' },
  },
  attribute_call = {
    target_nodes = { 'arguments' },
  },
  lambda = {
    target_nodes = { 'parameters' },
  },
  function_definition = {
    target_nodes = { 'parameters' },
  },
  enum_definition = {
    target_nodes = { 'enumerator_list' },
  },

  assignment = {
    target_nodes = { 'array', 'dictionary', 'arguments' },
  },
  augmented_assignment = {
    target_nodes = { 'array', 'dictionary', 'arguments' },
  },
  variable_statement = {
    target_nodes = { 'array', 'dictionary', 'arguments' },
  },
  const_statement = {
    target_nodes = { 'array', 'dictionary', 'arguments' },
  },
  return_statement = {
    target_nodes = { 'array', 'dictionary', 'arguments' },
  },
}
