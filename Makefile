preinstall-ts-parsers:
	nvim --headless -u tests/minimal.lua -c "TSUpdate | qa"

# LP string = language path
test-langs:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/langs/${LP} { minimal_init = 'tests/minimal.lua' }"

test-chold:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/chold {minimal_init = 'tests/minimal.lua'}"

# M string = mode 'start'|'end'|'hold'
test-chold-m:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/chold/${M}_spec.lua {minimal_init = 'tests/minimal.lua'}"

test-chold-r:
	nvim --headless -u tests/minimal.lua -c "PlenaryBustedDirectory tests/chold/hold_split_recursive_spec.lua {minimal_init = 'tests/minimal.lua'}"

test:
	make test-langs && make test-chold

lint-fix:
	stylua ./lua/treesj ./tests/langs/

docs:
	~/projects/code/github/panvimdoc/panvimdoc.sh \
	--project-name treesj \
	--input-file ./README.md \
	--vim-version 0.8.0 \
	--toc true \
	--description "" \
	--dedup-subheadings true \
	--demojify false \
	--treesitter true \
	--ignore-rawblocks false \
	--doc-mapping true \
	--doc-mapping-project-name true \
	--shift-heading-level-by 0 \
	--increment-heading-level-by 0 \
