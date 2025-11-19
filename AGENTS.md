# Neovim Configuration Handover Document

## Overview

This is a LazyVim-based Neovim configuration optimized for web development with advanced AI integration, debugging capabilities, and development tools. The setup is primarily focused on PHP (Laravel/WordPress), JavaScript/TypeScript (Next.js/Vue/React), and general web development workflows.

## Project Structure

```
~/.config/nvim/
├── init.vim                 # Entry point, loads Lua configuration
├── lua/
│   ├── lazy-init.lua       # Bootstrap script for lazy.nvim
│   ├── config/
│   │   ├── lazy.lua        # Lazy.nvim plugin manager setup
│   │   ├── options.lua     # Neovim options and performance settings
│   │   ├── keymaps.lua     # Custom keybindings (minimal, relies on LazyVim defaults)
│   │   └── autocmds.lua    # Auto commands (minimal, relies on LazyVim defaults)
│   └── plugins/
│       ├── avante.lua      # AI assistant integration (Claude & Moonshot)
│       ├── dev_tools.lua   # Development tools and language servers
│       ├── dap.lua         # Debug Adapter Protocol core setup
│       ├── dap_tools.lua   # DAP tools and PHP debugging
│       └── mini_pairs.lua  # Auto-pairs configuration override
├── lazyvim.json           # LazyVim extras configuration
├── .neoconf.json          # Neoconf LSP configuration
├── stylua.toml            # Lua formatting configuration
└── lazy-lock.json         # Plugin version lock file
```

## Key Configuration Files

### 1. Entry Point (`init.vim`)

- Sets up runtimepath compatibility with Vim
- Sources `~/.vimrc` for backward compatibility
- Loads the Lua configuration via `require('lazy-init')`

### 2. Core Configuration (`lua/config/`)

#### `options.lua`

- **Performance Optimization**: Configures temp directories to use RAM (`/tmp`) for speed
- **Environment Variable**: Uses `NVIM_TMP_DIR` if set, otherwise falls back to cache directory
- **Directories configured**:
  - Swap files: `$NVIM_TMP_DIR/swp//` or `~/.cache/nvim/swp//`
  - Undo files: `$NVIM_TMP_DIR/undo//` or `~/.cache/nvim/undo//`
  - Backup files: `$NVIM_TMP_DIR/bak//` or `~/.cache/nvim/bak//`

#### `lazy.lua`

- Configures lazy.nvim plugin manager
- Imports LazyVim base plugins and custom plugins
- Disabled performance-heavy plugins: `gzip`, `tarPlugin`, `tohtml`, `tutor`, `zipPlugin`
- Auto-updates plugins with notifications disabled

### 3. LazyVim Extras (`lazyvim.json`)

Extensive list of enabled LazyVim extras including:

- **AI**: Avante integration
- **Languages**: PHP, TypeScript, Vue, Python, Go, Rust, Docker, etc.
- **Tools**: DAP debugging, formatting (Prettier, Biome), linting (ESLint)
- **Editor**: Neo-tree, Harpoon2, FZF, refactoring tools
- **Utilities**: GitHub integration, project management, REST client

## Plugin Architecture

### AI Integration (`lua/plugins/avante.lua`)

**Avante.nvim** - AI-powered coding assistant

- **Providers**:
  - **Claude**: `claude-sonnet-4-20250514` (primary)
  - **Moonshot**: `kimi-k2-0711-preview` (alternative)
- **Configuration**:
  - Custom instructions file: `avante.md`
  - Temperature: 0.75, Max tokens: 20480 (Claude), 32768 (Moonshot)
  - Timeout: 30 seconds
- **Dependencies**: Telescope, nvim-cmp, img-clip, render-markdown

### Development Tools (`lua/plugins/dev_tools.lua`)

#### Mason Package Manager

**Automatically installed tools**:

- **LSP Servers**: `intelephense` (PHP), `typescript-language-server`, `html-lsp`, `css-lsp`, `bash-language-server`
- **Formatters**: `stylua`, `prettier`, `php-cs-fixer`, `pint` (Laravel)
- **Linters**: `eslint_d`, `phpstan`, `phpcs`

#### GitHub Copilot Integration

- **copilot.lua**: Code suggestions with Tab completion
- **CopilotChat.nvim**: AI chat interface with GPT-5 model
  - Layout: Vertical split (80 columns width)
  - Custom headers and auto-fold configuration

#### Code Formatting (Conform.nvim)

**Smart PHP formatting logic**:

1. **Laravel Pint**: Priority if `composer.json` contains `"laravel/pint"`
2. **PHPCS**: If `phpcs.xml` or `phpcs.xml.dist` found
3. **PHP-CS-Fixer**: Fallback option

#### Linting (nvim-lint)

- **JavaScript/TypeScript**: ESLint via `eslint_d`
- **PHP**: PHPStan static analysis
- **Bash**: Shellcheck

#### Git Integration

- **Gitsigns**: Line-by-line git integration with blame and diff
- **Key binding**: `<leader>gdiff` - Toggle git diff split

#### Terminal Integration (ToggleTerm)

**Specialized terminals**:

- `<leader>mg`: LazyGit (Git TUI)
- `<leader>md`: LazyDocker (Docker TUI)
- `<leader>mn`: NVM/NPM management (Bash float)

#### MCP Hub Integration

- **mcphub.nvim**: MCP Server Manager for AI agent orchestration
- **Avante Agent**: Local AI assistant endpoint integration
- **Key bindings**:
  - `<leader>af`: Send function/block to Avante
  - `<leader>ab`: Send entire buffer to Avante

### Debugging Setup (`lua/plugins/dap.lua` & `lua/plugins/dap_tools.lua`)

#### Debug Adapter Protocol (DAP)

**Core debugging features**:

- **Breakpoints**: `<leader>b` - Toggle breakpoint
- **Execution Control**:
  - `<leader>dr`: Run/Continue
  - `<leader>ds`: Step over
  - `<leader>di`: Step into
  - `<leader>do`: Step out
  - `<leader>dk`: Terminate
  - `<leader>dc`: Clear all breakpoints
- **UI**: `<leader>du` - Toggle DAP UI

#### PHP Debugging (Mason DAP)

- **Adapter**: `php-debug-adapter` (installed via Mason)
- **Xdebug Configuration**: Port 9003
- **Auto UI**: Automatically opens/closes DAP UI during debugging sessions

### Editor Enhancements (`lua/plugins/mini_pairs.lua`)

- **mini.pairs**: Auto-bracket pairing with custom ESC handling

## Language Server Configuration

### Supported Languages & Tools

| Language              | LSP Server                 | Formatter               | Linter     | Debugger          |
| --------------------- | -------------------------- | ----------------------- | ---------- | ----------------- |
| PHP                   | intelephense               | pint/phpcs/php-cs-fixer | phpstan    | php-debug-adapter |
| JavaScript/TypeScript | typescript-language-server | prettier                | eslint_d   | -                 |
| HTML                  | html-lsp                   | prettier                | -          | -                 |
| CSS                   | css-lsp                    | prettier                | -          | -                 |
| Lua                   | lua_ls                     | stylua                  | -          | -                 |
| Bash                  | bash-language-server       | -                       | shellcheck | -                 |

### Neoconf Integration (`.neoconf.json`)

- **Neodev**: Enhanced Lua development with plugin library support
- **lua_ls**: Enabled with full configuration

## Performance Optimizations

### Lazy Loading Strategy

- **Event-based loading**: Most plugins load on `VeryLazy`, `InsertEnter`, or specific commands
- **Conditional loading**:
  - Gitsigns only loads in Git repositories
  - VSCode integration only in VSCode context
- **Mason tools**: Load on-demand via commands

### Memory Management

- **Temp files in RAM**: Swap, undo, and backup files use `/tmp` for speed
- **Disabled plugins**: Removed unnecessary Vim plugins for faster startup
- **Plugin updates**: Background checking without notifications

## Code Style & Formatting

### Stylua Configuration (`stylua.toml`)

```toml
indent_type = "Spaces"
indent_width = 2
column_width = 120
```

### PHP Formatting Priority

1. **Laravel Pint** (Laravel projects)
2. **PHPCS** (WordPress/custom standards)
3. **PHP-CS-Fixer** (fallback)

## Key Bindings Summary

### AI & Development

- `<leader>af`: Send function to Avante AI
- `<leader>ab`: Send buffer to Avante AI
- `<Tab>`: Accept Copilot suggestion
- `<C-n>/<C-p>`: Navigate Copilot suggestions

### Debugging

- `<leader>b`: Toggle breakpoint
- `<leader>dr`: Debug run/continue
- `<leader>ds/di/do`: Step over/into/out
- `<leader>du`: Toggle debug UI
- `<leader>dk`: Terminate debug session

### Terminal & Git

- `<leader>mg`: LazyGit TUI
- `<leader>md`: LazyDocker TUI
- `<leader>mn`: NVM/NPM terminal
- `<leader>gdiff`: Toggle git diff split

## Environment Variables

### Required

- `NVIM_TMP_DIR` (optional): Custom temp directory for performance optimization

### AI Integration

- **Claude API**: Requires valid Anthropic API key for Avante
- **Moonshot API**: Alternative AI provider configuration

## Installation & Setup

### Prerequisites

1. **Neovim**: >= 0.9.0
2. **Node.js**: For language servers and formatters
3. **Git**: For plugin management
4. **Build tools**: For native plugin compilation

### First-time Setup

1. **LazyVim**: Automatically installs on first run
2. **Mason tools**: Run `:Mason` to verify installations
3. **AI setup**: Configure API keys in environment or Avante settings
4. **PHP debugging**: Ensure Xdebug is configured on port 9003

## Maintenance Tasks

### Regular Updates

```bash
# Update all plugins
:Lazy update

# Update Mason tools
:Mason
# Then 'U' to update all tools

# Check plugin health
:checkhealth
```

### Troubleshooting

#### Common Issues

1. **LSP not working**: Check `:LspInfo` and Mason installations
2. **Formatting fails**: Verify tool installation in `:Mason`
3. **Debug not connecting**: Check Xdebug configuration and port 9003
4. **Performance issues**: Verify temp directories are writable

#### Log Locations

- **Neovim logs**: `:messages` or `~/.cache/nvim/log`
- **LSP logs**: `:LspLog`
- **DAP logs**: Available in DAP console during debugging

## Development Workflow

### Typical Workflow

1. **Project opening**: LazyVim automatically detects project type
2. **LSP activation**: Language servers start based on file types
3. **Git integration**: Gitsigns shows changes in sign column
4. **AI assistance**: Avante available for code generation and refactoring
5. **Debugging**: DAP ready for PHP/web development debugging

### Best Practices

- **Use Mason**: Install all language tools through Mason for consistency
- **Lazy loading**: Keep plugins lazy-loaded for performance
- **Project-specific config**: Use `.neoconf.json` for project-specific LSP settings
- **AI integration**: Leverage Avante for complex refactoring and code generation

## Future Considerations

### Potential Improvements

1. **Docker integration**: Enhanced containerized development
2. **Test runners**: Integration with PHPUnit, Jest, etc.
3. **Additional AI providers**: OpenAI, local models via Ollama
4. **Performance monitoring**: Startup time optimization
5. **Custom snippets**: Project-specific code templates

### Plugin Migration Path

- **Dependencies**: All plugins use semantic versioning where possible
- **Configuration**: Modular design allows easy plugin replacement
- **LazyVim updates**: Follow LazyVim changelog for breaking changes

---

**Last Updated**: 2025-11-19
**Maintainer**: Previous development team
**Configuration Version**: LazyVim v8 compatible
