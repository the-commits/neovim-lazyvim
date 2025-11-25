-- ~/.config/nvim/lua/plugins/dap.lua
return {
  -- Debug Adapter Protocol (DAP) klient och UI/Widgets
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",

      { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
      { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
    },
    lazy = true,
    cmd = { "DapToggleBreakpoint", "DapContinue" },
  keys = {
    -- Standard keymaps for DAP
    {
      "<leader>b",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP: Toggle Breakpoint",
    },
    {
      "<leader>dr",
      function()
        require("dap").continue()
      end,
      desc = "DAP: Run/Continue",
    },
    -- Add all other DAP keymaps here (e.g. Step Over, Step Into, etc.)
    {
      "<leader>ds",
      function()
        require("dap").step_over()
      end,
      desc = "DAP: Step Over",
    },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "DAP: Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "DAP: Step Out",
      },
      {
        "<leader>dk",
        function()
          require("dap").terminate()
        end,
        desc = "DAP: Terminate",
      },
      {
        "<leader>dc",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "DAP: Clear all breakpoints",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dap-virtual-text").setup()

      -- DAP UI Settings
      dapui.setup({
        -- Minimal setup to ensure functionality
        controls = {
          layouts = {
            {
              elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 40,
              position = "right",
            },
            {
              elements = {
                "repl",
                "console",
              },
              size = 10,
              position = "bottom",
            },
          },
        },
        floating = {
          max_width = 80,
          max_height = 25,
        },
      })

      -- Automatic opening/closing of DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymaps to open/close UI
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })

      -- (External AI attach keymap removed)
    end,
  },
}
