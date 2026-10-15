return {
  -- MASON
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "pyright",
        "clangd",
        "clang-format",
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  }, -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal", -- Show parameter names for literals
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        pyright = {},
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "compile_commands.json",
              "compile_flags.txt",
              ".git",
              ".clangd"
            )(fname) or vim.fn.getcwd()
          end,
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      },
    },
  },
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lspemoji",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "emoji" },
      })
      opts.mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }
    end,
  },
}
