test:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"

test-langs:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/langs/ {minimal_init = 'tests/minimal.vim'}"

test-chold:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/chold/ {minimal_init = 'tests/minimal.vim'}"

lint-fix:
	stylua ./lua/treesj/
