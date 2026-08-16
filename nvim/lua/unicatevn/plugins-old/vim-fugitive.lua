return {
  'tpope/vim-fugitive',
  config = function(_)
    vim.keymap.set('n', '<leader>gs', "<cmd>G<CR>", { desc = "Fugitive: Status" })
    vim.keymap.set('n', '<leader>gp', "<cmd>G push<CR>", { desc = "Fugitive: Push" })
    vim.keymap.set('n', '<leader>gd', "<cmd>G diff<CR>", { desc = "Fugitive: Diff" })
  end
}
