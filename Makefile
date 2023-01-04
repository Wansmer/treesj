preinstall-ts-parsers:
	nvim --headless -u tests/minimal.lua -c "TSUpdate | qa"

test:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests {minimal_init = 'tests/minimal.lua'}"

test-langs:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/langs {minimal_init = 'tests/minimal.lua'}"

test-chold:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/chold {minimal_init = 'tests/minimal.lua'}"

lint-fix:
	stylua ./lua/treesj
