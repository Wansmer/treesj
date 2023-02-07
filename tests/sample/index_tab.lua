-- RESULT OF JOIN (node "block" (with noexpandtab), preset default)
if 1 == 1 then print('beep') end

-- RESULT OF SPLIT (node "block" (with noexpandtab), preset default)
if 1 == 1 then
	print('beep')
end

-- RESULT OF JOIN (node "table_constructor" (with noexpandtab), preset default)
local mixed = { 'one', two = 'two', 'three', dict, four = { 'four', 'five' } }

-- RESULT OF SPLIT (node "table_constructor" (with noexpandtab), preset default)
local mixed = {
	'one',
	two = 'two',
	'three',
	dict,
	four = { 'four', 'five' },
}
