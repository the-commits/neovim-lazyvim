-- ~/.config/nvim/lua/plugins/dap_tools.lua
return {
  -- (1) Mason DAP Integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    lazy = true,
    cmd = { "DapInstall", "DapUninstall", "DapToggleBreakpoint" },
    config = function()
      local dap = require("dap")

      -- MASON-NIM-DAP SETUP
      require("mason-nvim-dap").setup({
        -- Talar om för Mason vilka DAP-adaptrar som ska installeras
        ensure_installed = { "php-debug-adapter" },
      })

      -- 1. Adapter (Hur Neovim startar debug-servern)
      dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
        args = { "-p", 9003 }, -- VIKTIGT: Korrekt sökväg till Mason-binär
      }

      -- 2. Configuration (Hur Neovim ansluter till den)
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Lyssna efter Xdebug",
          port = 9003,
          -- source_mappings för Docker/WSL/Lokal miljö kan läggas till här
        },
      }
    end,
  },
}
