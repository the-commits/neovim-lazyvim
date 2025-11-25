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
        -- Tell Mason which DAP adapters should be installed
        ensure_installed = { "php-debug-adapter" },
      })

      -- 1. Adapter (How Neovim starts the debug server)
      dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
        args = { "-p", 9003 }, -- IMPORTANT: Correct path to Mason binary
      }

      -- 2. Configuration (How Neovim connects to it)
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          -- source_mappings for Docker/WSL/Local environment can be added here
        },
      }
    end,
  },
}
