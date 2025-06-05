vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.tf", "*.tfvars"},
    command = "set filetype=terraform"
})


vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.http", "*.rest"},
    command = "set filetype=http"
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "http",
--     callback = function()
--         vim.opt.foldenable = false  -- Disable folding
--         vim.opt.foldmethod = "manual"  -- Use manual folding
--     end,
-- })

vim.api.nvim_create_autocmd("User", {
  pattern = "RestResponsePre",
  callback = function()
    local res = _G.rest_response
    local json = vim.fn.system("jq .", res.body)
    if vim.v.shell_error == 0 then
      res.body = json
    end 
  end,
})
