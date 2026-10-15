return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          cpp = { "clang-format" },
          c = { "clang-format" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          lua = { "stylua" },
          python = { "black" },
          -- Add other file types as needed
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      -- Keymap for manual formatting
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range" })
    end,
  },
}
