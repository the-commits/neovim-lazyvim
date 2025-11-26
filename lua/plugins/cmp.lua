-- nvim-cmp mappings: arrows/Enter, leave Tab for Copilot
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Right>"] = cmp.mapping(function(fallback)
          local entry = cmp.get_selected_entry()
          if entry then
            cmp.confirm({ select = false })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Left>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = nil, -- free Tab for Copilot
        ["<S-Tab>"] = nil,
      })
      return opts
    end,
  },
}
