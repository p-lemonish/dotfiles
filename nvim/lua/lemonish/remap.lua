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
    vim.bo[args.buf].formatexpr = ""
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
vim.keymap.set("n", ")", "<C-d>zz")
vim.keymap.set("n", "(", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", ";", "<C-i>zz", { silent = true })
vim.keymap.set("n", ",", "<C-o>zz", { silent = true })

-- find&replace
vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- find&replace in selection
vim.keymap.set("v", "<leader>fr", [[<Esc>:'<,'>s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Go related fake snippets
vim.keymap.set("n", "<leader>er", "oif err != nil {<CR>return err<CR>}<Esc>")
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>log.Println(\"Error: %s\", err)<CR>}<Esc>")

-- Refactoring.nvim
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- exec py, go, or sh in a small split window with C-e
vim.keymap.set("n", "<C-e>", function()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local cmd

  if ft == "python" then
    -- Find project root by looking for .git directory
    local root = vim.fn.finddir(".git", file .. ";")
    if root ~= "" then
      root = vim.fn.fnamemodify(root, ":h")
      -- Make file path relative to git root
      local rel_file = vim.fn.substitute(file, "^" .. vim.fn.escape(root, "/") .. "/", "", "")
      cmd = "cd " .. vim.fn.shellescape(root) .. " && PYTHONPATH=. python3 " .. vim.fn.shellescape(rel_file)
    else
      -- No git root found, just run from current location
      cmd = "python3 " .. vim.fn.shellescape(file)
    end

  elseif ft == "go" then
    cmd = "go run ."
  elseif ft == "sh" or ft == "bash" then
    cmd = "bash " .. vim.fn.shellescape(file)
  else
    return
  end

  vim.cmd("botright split | resize 12 | terminal")
  local job = vim.b.terminal_job_id
  vim.api.nvim_chan_send(job, cmd .. "\n")
end, { desc = "Run current file (py/sh) or go run ." })

