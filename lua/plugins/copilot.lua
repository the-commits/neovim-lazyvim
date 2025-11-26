-- GitHub Copilot integration and keymaps
return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true -- we'll map <Tab> ourselves
      vim.g.copilot_assume_mapped = true
    end,
    config = function()
      -- Accept suggestion with Tab
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn['copilot#Accept']("")
      end, { expr = true, silent = true, desc = "Copilot: Accept" })

      -- Cycle suggestions with Ctrl+Left / Ctrl+Right
      vim.keymap.set("i", "<C-Left>", function()
        vim.cmd([[call copilot#Previous()]])
      end, { silent = true, desc = "Copilot: Previous" })
      vim.keymap.set("i", "<C-Right>", function()
        vim.cmd([[call copilot#Next()]])
      end, { silent = true, desc = "Copilot: Next" })

      -- Toggle Copilot
      vim.keymap.set({"n","i"}, "<leader>ct", ":Copilot toggle<CR>", { silent = true, desc = "Copilot: Toggle" })
    end,
  },
}
