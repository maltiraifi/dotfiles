return {
  {
    "nvim-treesitter/nvim-treesitter",
    --[tag = "v0.9.1",]--
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "gitignore",
        "graphql",
        "http",
        "json",
        "sql",
        "vim",
        "lua",
        "java",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
