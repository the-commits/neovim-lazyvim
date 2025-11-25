# Neovim Configuration Guide for AI Agents

## Build/Lint/Test Commands

### Formatting Commands
- `:Format` - Format current buffer (uses conform.nvim with language-specific formatters)
- `:FormatWrite` - Format and write current buffer
- For Lua: Uses Stylua (configured with 2-space indentation)
- Run `stylua .` to format all Lua files in project
- For single file: `stylua filename.lua`

### Linting Commands
- `:Lint` - Run linters on current buffer
- `:LintToggle` - Toggle linting on/off
- Lua: No specific linter configured
- Uses LazyVim's integrated linting for other languages

### Testing
- No specific test runner configured in this setup
- Use terminal (`:terminal` or `<leader>sp1` for opencode terminal) to run project-specific test commands
- For Lua plugins: Use `plenary.nvim` test framework if available
- To run a single test, use the terminal to execute the specific test command for your project

## Code Style Guidelines

### Imports
- Lua: Use `require()` for module imports
- Follow existing patterns in `lua/plugins/` directory
- Group standard library imports separately from plugin imports
- Use relative paths for local modules

### Formatting
- Indentation: 2 spaces (Stylua config: `stylua.toml`)
- Line width: 120 characters
- No trailing whitespace
- Consistent spacing around operators
- Use spaces around = in tables: `{ key = value }`

### Types
- Lua: No static typing (dynamically typed)
- Use descriptive variable names
- Follow existing naming conventions in codebase
- Use type annotations in comments when helpful

### Naming Conventions
- Variables/functions: camelCase
- Files: snake_case.lua
- Plugin configurations: Match plugin documentation style
- Private functions: prefixed with underscore (_privateFunction)

### Error Handling
- Use `pcall()` for safe function calls
- Check return values before using them
- Provide meaningful error messages when possible
- Use `vim.notify()` for user-facing errors

## AI Integration

### Opencode
- `<leader>og` - Toggle Opencode UI
- `<leader>oi` - Open input window
- `<leader>oo` - Open output window
- `<leader>od` - Open diff view
- `:Opencode` - Main command
- Terminal access: `<leader>sp1`

## Key Development Tools

### Debugging (DAP)
- `<leader>b` - Toggle breakpoint
- `<leader>dr` - Run/Continue debugging
- `<leader>ds/di/do` - Step over/into/out
- `<leader>du` - Toggle debug UI

### Git Integration
- `<leader>mg` - LazyGit terminal
- `<leader>gdiff` - Toggle git diff split

### Project Management
- `<leader>fp` - Find project files
- `<leader>fw` - Find words in project