vim.g.mapleader = " "
vim.keymap.set("n", "<leader>dv", vim.cmd.Ex)

-- Copy to global clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y', { noremap = true })

vim.keymap.set({ "n", "v" }, "=", function()
  vim.lsp.buf.format()
end, { noremap = true, silent = true })

-- LSP related
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, { noremap = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
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

-- Movement with centering
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", ";", "<C-i>zz", { silent = true })
vim.keymap.set("n", ",", "<C-o>zz", { silent = true })

-- Go related fake snippets
vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>er", "oif err != nil {<CR>return err<CR>}<Esc>")
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>log.Println(\"Error: %s\", err)<CR>}<Esc>")

-- Refactoring.nvim
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
