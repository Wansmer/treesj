local lang_utils = require('treesj.langs.utils')

local args = lang_utils.set_preset_for_args()
local list_no_space = lang_utils.set_preset_for_list({
  join = {
    space_in_brackets = false,
  },
})
local list_space = lang_utils.set_preset_for_list()
local statement = lang_utils.set_preset_for_statement()
local target_args = { target_nodes = { 'argument_list' } }
local target_block = { target_nodes = { 'block' } }
local target_creation = {
  target_nodes = { 'argument_list', 'initializer_expression' },
}
local target_param_list = { target_nodes = { 'parameter_list' } }
local type_args = lang_utils.set_preset_for_args({
  both = {
    last_separator = false,
  },
})

return {
  accessor_list = statement,
  argument_list = args,
  attribute = {
    target_nodes = { 'attribute_argument_list' },
  },
  attribute_argument_list = args,
  attribute_list = list_no_space,
  block = statement,
  bracketed_argument_list = args,
  bracketed_parameter_list = args,
  catch_clause = target_block,
  checked_statement = target_block,
  collection_expression = list_no_space,
  constructor_declaration = target_param_list,
  constructor_initializer = target_args,
  conversion_operator_declaration = target_param_list,
  delegate_declaration = target_param_list,
  do_statement = target_block,
  element_access_expression = {
    target_nodes = { 'bracketed_argument_list' },
  },
  element_binding_expression = args,
  enum_declaration = {
    target_nodes = { 'enum_member_declaration_list' },
  },
  enum_member_declaration_list = list_space,
  finally_clause = target_block,
  fixed_statement = target_block,
  for_statement = target_block,
  foreach_statement = target_block,
  if_statement = target_block,
  implicit_object_creation_expression = target_creation,
  indexer_declaration = {
    target_nodes = { 'bracketed_parameter_list' },
  },
  initializer_expression = list_space,
  invocation_expression = target_args,
  list_pattern = list_no_space,
  local_function_statement = target_param_list,
  lock_statement = target_block,
  method_declaration = target_param_list,
  object_creation_expression = target_creation,
  operator_declaration = target_param_list,
  parameter_list = args,
  property_pattern_clause = list_space,
  switch_expression = lang_utils.set_preset_for_list({
    both = {
      -- don't format the thing being evaluated or the `switch` keyword
      shrink_node = { from = '{', to = '}' },
    },
  }),
  try_statement = target_block,
  tuple_expression = args,
  tuple_type = args,
  type_argument_list = type_args,
  type_parameter_list = type_args,
  unsafe_statement = target_block,
  using_statement = target_block,
  while_statement = target_block,
}
