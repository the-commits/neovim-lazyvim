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
                return "opencode"
              end,
            },
            gemini = {
              cmd = function()
                return "gemini"
              end,
            },
          },
          auto_terminal_keymaps = function()
            local keymaps = {
              ["o"] = "opencode",
              ["g"] = "gemini",
            }
            for key, term in pairs(keymaps) do
              vim.api.nvim_set_keymap(
                "n",
                "<leader>a" .. key,
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
