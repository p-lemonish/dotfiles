vim.g.mapleader = " "
vim.keymap.set("n", "<leader>dv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y', { noremap = true })
vim.keymap.set({ "n", "v" }, "=", function()
  vim.lsp.buf.format()
end, { noremap = true, silent = true })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
})
vim.keymap.set("n", "<leader>of", function()
  vim.diagnostic.open_float(nil, {
    focusable = true,
    scope = "cursor",
    border = "rounded"
  })
end, { desc = "Show diagnostic (focusable float)" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>:q<CR>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", ";", "<C-i>", { silent = true })
vim.keymap.set("n", ",", "<C-o>", { silent = true })

vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>er", "oif err != nil {<CR>return err<CR>}<Esc>")
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>log.Println(\"Error: %s\", err)<CR>}<Esc>")
