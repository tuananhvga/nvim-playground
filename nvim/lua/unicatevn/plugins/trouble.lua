return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    -- Lua
    vim.keymap.set("n", "<leader>dw", function() require("trouble").toggle("workspace_diagnostics") end,
      { desc = "Diagnose workspace" })
    vim.keymap.set("n", "<leader>db", function() require("trouble").toggle("document_diagnostics") end,
      { desc = "Diagnose buffer" })
    vim.keymap.set("n", "<leader>dq", function() require("trouble").toggle("quickfix") end,
      { desc = "Diagnose quickfix list" })
    vim.keymap.set("n", "<leader>dl", function() require("trouble").toggle("loclist") end,
      { desc = "Diagnose location list" })
  end
}
