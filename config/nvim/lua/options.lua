require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.foldmethod = "indent"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "terraform",
  callback = function()
    vim.bo.commentstring = "# %s"
  end
})
