-- ~/.config/nvim/lua/plugins/dev_tools.lua
return {

  -- 1. Optimera Mason: LSP- och verktygshantering (Laddas ENDAST vid kommando)
  {
    "mason-org/mason.nvim", -- Korrekt repository-namn
    lazy = true,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
    opts = {
      ensure_installed = {
        -- LSP Servers för din Webbutvecklingsstack
        "intelephense",                 -- PHP (Laravel/Wordpress)
        "typescript-language-server",   -- TypeScript/JavaScript (NextJS/Vue/React/Vanilla JS)
        "html-lsp",                     -- HTML
        "css-lsp",                      -- CSS
        "bash-language-server",         -- Bash-stöd (För Fas 3)

        -- Formaterare & Lintrar (Binärer)
        "stylua",                       -- Lua formatter
        "prettier",                     -- Grundläggande JS/TS/CSS formatter
        "eslint_d",                     -- JavaScript/TypeScript linter
        "phpstan",                      -- PHP Static Analysis (För Fas 2)
      },
    },
  },

  -- 2. Copilot Integration (Laddas ENDAST vid InsertEnter)
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter", -- Ladda endast när du går in i Insert Mode (maximal prestanda)
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75, -- Snabb respons
        keymap = {
          accept = "<C-f>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = false },
      -- Definiera filtyper där Copilot ska aktiveras (implicit avaktiverad annars)
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

  -- 3. Formatering (Conform) - Laddas endast vid spara/kommando
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" }, -- Ladda *innan* spara
    cmd = "ConformInfo",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "only_with_markers",
        async = true,
      },
      formatters_by_ft = {
        javascript = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
        vue = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        -- PHP-formatering kommer att hanteras dynamiskt i Fas 2
        php = { "phpcsfixer" }, -- Standard fallback
        lua = { "stylua" },
      },
    },
  },

  -- 4. Linting (nvim-lint) - Laddas endast efter spara
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufWritePost" }, -- Kör linting efter sparning
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        php = { "phpstan" }, -- Mason hanterar binären, nvim-lint kör den
        bash = { "shellcheck" },
      },
    },
  },

  -- 5. Versionskontroll (Gitsigns) - Laddas endast i Git-repos
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
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = vim.keymap.set
        map("n", "<leader>gp", gs.prev_hunk, { buffer = bufnr, desc = "Gitsigns: Föregående Hunk" })
        map("n", "<leader>gn", gs.next_hunk, { buffer = bufnr, desc = "Gitsigns: Nästa Hunk" })
      end,
    },
  },

  -- 6. TUI / Terminaler (ToggleTerm) - Laddas endast vid kommando
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    opts = {
      direction = "float",
      shading_factor = 1,
      start_in_insert = false,
      persist_mode = false,
      terminal_mappings = true,
      hidden = true,
    },
    keys = {
      -- LazyGit
      {
        "<leader>gg",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", direction = "float" }):toggle()
        end,
        desc = "TUI: LazyGit (Float)",
      },
      -- LazyDocker
      {
        "<leader>gD",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazydocker", direction = "float" }):toggle()
        end,
        desc = "TUI: LazyDocker (Float)",
      },
    },
  },

  -- 7. MCP / Avante Integration (Förberedelse Fas 4 - Lägg till mcphub)
  {
    "ravitemer/mcphub.nvim", -- MCP Server Manager för Neovim
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    lazy = true,
    cmd = "MCPHub", -- Laddas endast när du öppnar TUI för MCP
    config = function()
      require("mcphub").setup({
        port = 3000,
        -- Avante-integration läggs till i Fas 4
      })
    end,
  },
}
