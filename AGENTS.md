# AI Agents Guide (Neovim config)

## Build / Lint / Test
- **Build**: `:lua require('lazy').sync()` – sync plugins & compile Lua.
- **Lint**: `:LspInfo` (via built‑in LSP) or `:Format`/`:FormatWrite` (stylua).
- **Test**: `lua require('plenary.test_harness').test_directory('lua', {minimal_init='tests/minimal_init.lua'})`.
- **Single test**: `nvim --headless -c "PlenaryBustedDirectory tests/<test_file>.lua { minimal_init = 'tests/minimal_init.lua' }" -c qa`.

## Code Style Guidelines
- **Imports**: `local foo = require('module.foo')`; separate stdlib, external, and local modules; alphabetical within groups.
- **Formatting**: 2‑space indentation, max line length 120, no trailing whitespace, spaces around `=` in tables.
- **Types**: Dynamic Lua; annotate complex structures with comments (`---@type table<string,number>`).
- **Naming**:
  - Functions & variables: `camelCase`.
  - Files: `snake_case.lua`.
  - Private helpers: prefix with `_`.
- **Error handling**: Wrap risky calls in `pcall`, check results, and report via `vim.notify('msg', vim.log.levels.ERROR)`.

## Tooling & Keymaps
- **Opencode**: `:Opencode`, `<leader>og/oi/oo/od`.
- **Debug**: `<leader>b`, `<leader>dr`, `<leader>ds/di/do`, `<leader>du`.
- **Git**: `<leader>mg` (LazyGit), `<leader>gdiff`.

## Cursor / Copilot Rules
- No cursor rules found (`.cursor/rules/` absent).
- No Copilot instructions (`.github/copilot-instructions.md` absent).