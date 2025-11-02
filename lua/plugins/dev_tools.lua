-- ~/.config/nvim/lua/plugins/dev_tools.lua
return {
  { "nvim-neotest/nvim-nio", lazy = true },

  {
    "mason-org/mason.nvim",
    lazy = true,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
    opts = {
      ensure_installed = {
        -- LSP Servers för din Webbutvecklingsstack
        "intelephense", -- PHP (Laravel/Wordpress)
        "typescript-language-server", -- TypeScript/JavaScript (NextJS/Vue/React/Vanilla JS)
        "html-lsp", -- HTML
        "css-lsp", -- CSS
        "bash-language-server",
        "stylua", -- Lua formatter
        "prettier", -- Grundläggande JS/TS/CSS formatter
        "eslint_d", -- JavaScript/TypeScript linter
        "phpstan", -- PHP Static Analysis
        "php-cs-fixer", -- PHP Code Formatter
        "pint", -- Laravel Pint Formatter
        "phpcs", -- PHP Code Sniffer
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<tab>",
          next = "<C-n>",
          prev = "<C-p>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        javascript = true,
        typescript = true,
        html = true,
        css = true,
        php = true,
        lua = true,
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
      model = "gpt-5", -- AI model to use
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        -- width = 0.275, -- 27.5% of screen width
        width = 80, -- Fixed width in columns
        height = 1.0, -- Fixed height in rows
        border = "rounded", -- 'single', 'double', 'rounded', 'solid'
        title = "🤖 AI Assistant",
        zindex = 100, -- Ensure window stays on top
      },
      headers = {
        user = "👤 You",
        assistant = "🤖 Copilot",
        tool = "🔧 Tool",
      },

      separator = "━━",
      auto_fold = true, -- Automatically folds non-assistant messages
      auto_insert_mode = true, -- Enter insert mode when opening
    },
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- PHP formateringslogik
        php = {
          -- Pint (Laravel): Prioritet 1 om den hittar Pint i composer.json
          {
            name = "pint",
            condition = function(ctx)
              local composer_path = vim.fn.findfile("composer.json", ctx.dirname)
              if composer_path ~= "" then
                local content = table.concat(vim.fn.readfile(composer_path), "\n")
                return string.find(content, '"laravel/pint"')
              end
              return false
            end,
          },
          -- PHPCS (WordPress/Generellt): Prioritet 2 om den hittar phpcs-konfiguration
          {
            name = "phpcs",
            condition = function(ctx)
              return vim.fn.findfile("phpcs.xml", ctx.dirname) ~= ""
                or vim.fn.findfile("phpcs.xml.dist", ctx.dirname) ~= ""
            end,
          },
          -- Fallback: php-cs-fixer
          "php-cs-fixer",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufWritePost" }, -- Kör linting efter sparning
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        php = { "phpstan" }, -- phpstan installerad via Mason
        bash = { "shellcheck" },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    -- Laddas endast om vi hittar en .git-katalog uppåt i trädet.
    cond = function()
      return vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= ""
    end,
    opts = {
      sign_priority = 6,
      attach_to_untracked = true,
      current_line_blame = true,
      word_diff = true,
    },
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    opts = {
      direction = "horizontal",
      shading_factor = 1,
      size = 15,
      persist_mode = false,
      terminal_mappings = true,
      hidden = true,
    },
    keys = {
      -- LazyGit
      {
        "<leader>mg",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazygit" }):toggle()
        end,
        desc = "TUI: LazyGit (Float)",
      },
      -- LazyDocker
      {
        "<leader>md",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazydocker" }):toggle()
        end,
        desc = "TUI: LazyDocker (Float)",
      },
      -- NVM/NPM Terminal
      {
        "<leader>mn", -- 'm' för Management, 'n' för NVM/NPM
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "bash", direction = "float" }):toggle()
        end,
        desc = "TUI: NVM/NPM (Bash Float)",
      },
    },
  },

  {
    "ravitemer/mcphub.nvim", -- MCP Server Manager för Neovim
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    lazy = true,
    cmd = "MCPHub", -- Laddas endast när du öppnar TUI för MCP
    config = function()
      require("mcphub").setup({
        port = 3000, -- KORREKT PORT för mcphub
        agents = {
          -- AVANTE AGENT DEFINITION
          avante = {
            name = "Avante AI Assistant",
            endpoint = "http://localhost:3001/api/process-context", -- Antagen port för Avante-tjänsten
            description = "Din lokala AI-assistent för kodgenerering, refactoring och snabb analys.",
            is_default = true,
          },
        },
        -- Keymaps för Avante-interaktion
        keymaps = {
          -- Skicka aktuell funktion/kodblock till standard-agenten (Avante)
          ["<leader>af"] = {
            command = "MCPHub send_function",
            desc = "Avante: Skicka funktion/block för analys/refactoring",
          },
          -- Skicka hela bufferten till standard-agenten (Avante)
          ["<leader>ab"] = {
            command = "MCPHub send_buffer",
            desc = "Avante: Skicka hela bufferten",
          },
        },
      })
    end,
  },

  -- VSCode Neovim Multi-Cursor Support
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    cond = not not vim.g.vscode,
    opts = {},
  },
}
