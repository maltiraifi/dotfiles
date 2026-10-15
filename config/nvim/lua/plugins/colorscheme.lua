--[=[return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme("sonokai")
    end,
  },
}
]=]
--[=[return {
  {
    "dylanaraps/wal.vim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme wal")
    end,
  },
}
]=]

return {
  {
    "uZer/pywal16.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd("colorscheme pywal16")
    end,
  },
}
