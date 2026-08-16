return {
  'klen/nvim-test',
  config = function()
    require('nvim-test').setup({})
    vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>TestFile<CR>', { noremap = true, silent = true, desc = "Test file" })
    vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>TestNearest<CR>',
      { noremap = true, silent = true, desc = "Test nearest" })
    vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>TestLast<CR>', { noremap = true, silent = true, desc = "Test last" })
  end,
}
