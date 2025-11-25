return {
  {
    "greenarmor/speckit.nvim",
    opts = {
      overrides = {
        lsp = { servers = { lua_ls = true, tsserver = true, pyright = true } },
        ai = {
          terminals = {
            opencode = {
              cmd = function()
                -- Add error handling to the opencode terminal command
                local success, result = pcall(function()
                  return "opencode"
                end)
                if success then
                  return result
                else
                  print("Error: opencode command not available")
                  return ""
                end
              end,
            },
          },
          -- Improved keymap configuration for better extensibility
          -- To add new terminal keymaps, extend the terminal_keymaps table:
          -- require('speckit').terminal_keymaps = { ["2"] = "other_terminal" }
          terminal_keymaps = {
            ["1"] = "opencode",
          },
          auto_terminal_keymaps = function()
            -- Use the terminal_keymaps table for easier extension
            local keymaps = vim.tbl_deep_extend("force", 
              { ["1"] = "opencode" },
              require('speckit').terminal_keymaps or {}
            )
            for key, term in pairs(keymaps) do
              vim.api.nvim_set_keymap(
                "n",
                "<leader>sp" .. key,
                string.format(":lua require('speckit').terminals.%s.cmd()<CR>", term),
                { noremap = true, silent = true }
              )
            end
          end,
          trigger_formatting = { enabled = true, timeout_ms = 4000 },
        },
      },
    },
  },
}