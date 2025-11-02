-- ~/.config/nvim/lua/plugins/dev_tools.lua
return {

  -- 1. Optimera Mason: Ladda ENDAST vid kommando
  {
    "mason-org/mason.nvim",
    lazy = true,
    -- Tar bort alla filetype eller event triggers.
    -- Laddas endast när användaren explicit kör ett Mason-kommando.
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
    opts = {
      -- Exempel: Behåll dina installerade paket (om du vill ha dem via Mason)
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        -- ... lägg till dina verktyg här
      },
    },
  },

  -- ~/.config/nvim/lua/plugins/dev_tools.lua (fortsättning)
  -- 2. Optimera Gitsigns: Ladda endast i Git-repos
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    -- Använd cond: laddas endast om vi hittar en .git-katalog uppåt i trädet.
    cond = function()
      return vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= ""
    end,
    -- Vi kan behålla resten av konfigurationen som den är (eller lägga till opts här)
  },
  -- ~/.config/nvim/lua/plugins/dev_tools.lua (fortsättning)
  -- 3. Integration med LazyGit/LazyDocker via ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" }, -- Ladda vid kommando
    -- Om du använder LazyVims extra för toggleterm, är det ofta redan konfigurerat.
    -- Vi lägger till keymaps för att starta dina program:
    opts = {
      direction = "float", -- Använd flytande fönster (snyggast för TUI som LazyGit)
      -- Lägg till dina egna terminaler som använder LazyGit och LazyDocker
      shading_factor = 1, -- Gör bakgrunden transparent
      start_in_insert = false,
      persist_mode = false,
      terminal_mappings = true,
      hidden = true,
    },
    keys = {
      -- Keymap för LazyGit
      {
        "<leader>gg",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", direction = "float" }):toggle()
        end,
        desc = "LazyGit (Float)",
      },
      -- Keymap för LazyDocker (om installerat)
      {
        "<leader>gD",
        function()
          require("toggleterm.terminal").Terminal:new({ cmd = "lazydocker", direction = "float" }):toggle()
        end,
        desc = "LazyDocker (Float)",
      },
    },
  },
}
