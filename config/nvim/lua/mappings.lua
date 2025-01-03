require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>ws", "<cmd>w<CR>", { desc = "General Save file" })
map({ "n", "t" }, "<C-`>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm", size = 0.8}
end, { desc = "Terminal toggle floating term" })
map("n", "<leader>ti", function ()
  if vim.lsp.inlay_hint.is_enabled() then
    vim.lsp.inlay_hint.enable(false, {0})
  else
    vim.lsp.inlay_hint.enable(true, {0})
  end
end, { desc = "Toggle inlay hint"}
)

map("i", "jk", "<ESC>")

map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit"})

map("n", "<leader>oy", "<cmd>Yazi<cr>", { desc = "Open Yazi"})
map("n", "<leader>ty", "<cmd>Yazi toggle<cr>", { desc = "Open Yazi on current dir"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
