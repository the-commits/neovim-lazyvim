-- ~/.config/nvim/lua/plugins/opencode.lua
-- Neovim frontend for the opencode terminal AI agent
-- Adds :Opencode command and basic keymaps
return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      },
      -- Optional completion & picker backends are already provided by LazyVim (cmp, telescope)
    },
    cmd = { "Opencode" },
    keys = {
      { "<leader>og", function() require("opencode.api").toggle() end, desc = "Opencode: Toggle UI" },
      { "<leader>oi", function() require("opencode.api").open_input() end, desc = "Opencode: Open Input" },
      { "<leader>oo", function() require("opencode.api").open_output() end, desc = "Opencode: Open Output" },
    },
    config = function()
      -- Use defaults; adjust here if you want custom behavior
      require("opencode").setup({
        -- You can add custom config here later, e.g.
        -- default_mode = "build",
        -- ui = { icons = { preset = "text" } },
      })
    end,
  },
}
