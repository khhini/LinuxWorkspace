require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>ws", "<cmd>w<CR>", { desc = "General Save file" })
map("n", "<leader>qt", "<cmd>q<cr>", { desc = "Close current tab"})
map("n", "<leader>qa", "<cmd>q<cr>", { desc = "Close everyting"})
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

-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit"})

-- Yazi
map("n", "<leader>oy", "<cmd>Yazi<cr>", { desc = "Open Yazi"})
map("n", "<leader>ty", "<cmd>Yazi toggle<cr>", { desc = "Open Yazi on current dir"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Rest.Nvim
map("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run http ceient on current cursor. Split vertical"})
map("n", "<leader>rhr", "<cmd>hor Rest run<cr>", { desc = "Run http client on current cursor. Split horizontal"})
map("n", "<leader>re", "<cmd>Telescope rest select_env<cr>", {desc = "Change rest-nvim env"})

map( "n", "<leader>ga" , "<cmd>CodeCompanionActions<cr>", { desc = "Open CodeCompanion actions", noremap = true, silent = true })
map( "n", "<leader>gcc" , "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Open CodeCompanion chat",  noremap = true, silent = true })
map( "v", "<leader>gca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Open CodeCompanion chat with added context", noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
