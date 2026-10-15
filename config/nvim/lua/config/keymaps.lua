local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", "_x")

-- increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", "tabclose<Return>", opts)

-- Split Window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move Window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Updating pywal for nvim colorscheme
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd("source ~/.cache/wal/colors-wal.vim")
  vim.cmd("colorscheme wal")
end, { desc = "Reload Pywal colorscheme" })

local luasnip = require("luasnip")

-- Expand snippet or jump to next placeholder
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true, desc = "Expand snippet or jump to next placeholder" })

-- Jump to previous placeholder
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true, desc = "Jump to previous placeholder" })

-- Select choice (for choice nodes, if used)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true, desc = "Cycle snippet choices" })
