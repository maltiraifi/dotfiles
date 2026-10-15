return {
  {
    "L3MON4D3/LuaSnip",

    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      -- My pywal setup
      "uZer/pywal16.nvim",
    },
    opts = function(_, opts)
      opts.snippets = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "luasnip" })
    end,
  },
}
