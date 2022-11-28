# How to add a new language and create tests for it

1. Add preset for new language to `/lua/treesj/langs/%{name_of_language}.lua`;
2. Update `langs` list in [/lua/treesj/langs/init.lua](/lua/treesj/langs/init.lua);
3. Create new file in `/tests/sample/` with name `index.${type_of_file}` - it
   will be file with examples of result `split` and `join`;
4. Duplicate file `template.lua`, remane it to `${you_language}_spec.lua` and add describe and data for tests;
5. Update list of supported languages in project [README.md](/README.md);

## Data for tests

**File**: `/tests/langs/${you_language}_spec.lua`

```lua
local tests_data = {
  {
    path = PATH, -- path to file with examples of format (/tests/sample/index.${type_of_file})
    mode = MODE, -- mode, for which current test
    lang = LANG, -- lang, for which current test
    desc = 'lang "%s", node "NAME_OF_NODE", preset default', -- test describe
    cursor = { 1, 0 }, -- start cursor position { row, column } (row is 1-based index, column is 0-based)
    expected = { 0, 0 }, -- range of expected result { row start (0-based), row end (0-based, but not inclusive)}
    result = { 0, 0 }, -- range of result running plugin where it will placed { row start (0-based), row end (0-based, but not inclusive)}
    settings = {}, -- for overriding default settings (for whole plugin, no only preset. For change preset, use new _spec file)
  },
}
```

### Expected result and real result

**File**: `/tests/sample/index.${type_of_file}`

```javascript
// RESULT OF JOIN (node "object", preset default)
const obj = { one: 'one', two: [ 1, 2 ], three: { one: 'one', two: [ 1, 2 ] } };

// RESULT OF SPLIT (node "object", preset default)
const obj = {
  one: 'one',
  two: [ 1, 2 ],
  three: { one: 'one', two: [ 1, 2 ] },
};
```

Imagine that this piece of code starts on the first line of the file. The data for the test will be:

```lua
local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 2, 16 },
    expected = { 3, 8 },
    result = { 1, 6 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 5, 9 },
    expected = { 1, 2 },
    result = { 4, 5 },
    settings = {},
  },
}
```

## Execution

1. File with examples will be open with minimal vim config, cursor will be set to row and column according `data.cursor`;
2. Result from range of `data.expected` will be saved for compare;
3. TreeSJ will be start for node under cursor;
4. Result of formatting will be saved and compare with expected line by line.
