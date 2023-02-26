preinstall-ts-parsers:
	nvim --headless -u tests/minimal.lua -c "TSUpdate | qa"

# LP string = language path
test-langs:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/langs/${LP} {minimal_init = 'tests/minimal.lua'}"

test-langs-tab:
	nvim --headless -u tests/minimal_tab.lua -c "PlenaryBustedDirectory tests/langs_tab {minimal_init = 'tests/minimal_tab.lua'}"

test-chold:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/chold {minimal_init = 'tests/minimal.lua'}"

test:
	make test-langs && make test-langs-tab && make test-chold

lint-fix:
	stylua ./lua/treesj
