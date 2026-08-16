local open_tmux_window = function()
  print(vim.inspect())
  local curPath = vim.fn.expand('%:p:h')
  if vim.fn.isdirectory(curPath) == 0 then
    local oilEntry = require("oil").get_cursor_entry()
    local oilPath = string.sub(curPath, 7)
    if oilEntry == nil or oilEntry.type == 'file' then
      curPath = oilPath
    else
      curPath = oilPath .. '/' .. oilEntry.name
    end
  end
  local curBasePath = vim.fs.basename(curPath)
  vim.cmd("silent !tmux neww -c " .. curPath .. " -n " .. curBasePath)
end

vim.g.mapleader = ","

-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']q', '<cmd>cn<CR>',
  { noremap = true, silent = true, desc = "Go to next quickfix item" })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cp<CR>',
  { noremap = true, silent = true, desc = "Go to previous quickfix item" })
vim.api.nvim_set_keymap('n', ']b', '<cmd>bn<CR>',
  { noremap = true, silent = true, desc = "Go to next buffer" })
vim.api.nvim_set_keymap('n', '[b', '<cmd>bp<CR>', { noremap = true, silent = true, desc = "Go to previous buffer" })

-- Diff keymap
vim.api.nvim_set_keymap('n', '<leader>gw', '<cmd>Gwrite<CR>', { noremap = true, silent = true, desc = "Git write" })
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>Gvdiffsplit!<CR>',
  { noremap = true, silent = true, desc = "Three ways git diff" })
vim.keymap.set('n', '<leader>dp', function()
  vim.cmd('diffput')
  vim.cmd('diffupdate')
end, { desc = "Diff put" })
vim.keymap.set('n', '<leader>dg', function()
  vim.cmd('diffget')
  vim.cmd('diffupdate')
end, { desc = "Diff get" })
vim.keymap.set('n', '<leader>df', function()
  vim.cmd('diffget //2')
  vim.cmd('diffupdate')
end, { desc = "Diff get target branch" })
vim.keymap.set('n', '<leader>dj', function()
  vim.cmd('diffget //3')
  vim.cmd('diffupdate')
end, { desc = "Diff get merge branch" })

vim.keymap.set('n', '<leader>pa', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, { desc = 'Copy file path' })
vim.keymap.set('n', '<leader>pr', function() vim.fn.setreg('+', vim.fn.expand('%:.')) end, { desc = 'Copy file relative path' })
vim.keymap.set('n', '<leader>pd', function() vim.fn.setreg('+', vim.fn.expand('%:p:h')) end,
  { desc = 'Copy directory path' })

-- Open tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux_sessionizer<CR>", { desc = "Open tmux sessionizer" })

-- Open new tmux windows at current file's directory
vim.keymap.set("n", "<leader>e", open_tmux_window , { desc = "Open new shell at current file's directory" })

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
