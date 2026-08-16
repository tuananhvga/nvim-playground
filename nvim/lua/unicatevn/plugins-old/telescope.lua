return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  config = function()
    local lga_actions = require("telescope-live-grep-args.actions")
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
    require("telescope").setup({
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "horizontal",
          layout_config = {
            preview_height = 0.8,
          },
          mappings = {
            i = {
              ["<s-cr>"] = require("telescope-undo.actions").yank_additions,
              ["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<cr>"] = require("telescope-undo.actions").restore
            },
          },
        },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {         -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = lga_actions.to_fuzzy_refine,
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        }
      },
    })
    require("telescope").load_extension("undo")
    require("telescope").load_extension("live_grep_args")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git', '--color', 'never' },
      })
    end, { desc = "Telescope: Find Files" })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope: Git Files" })
    vim.keymap.set('n', '<leader>fs', function ()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end, { desc = "Telescope: Live Grep" })
    vim.keymap.set('v', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection, { desc = "Telescope: Live Grep visual selection" })
    vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = "Telescope: Treesitter" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope: Buffers" })
    vim.keymap.set('n', '<leader>fa', builtin.builtin, { desc = "Telescope: Arbitrary" })
    vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = "Telescope: Command History" })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "Telescope: LSP References" })
    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Telescope: Undo" })
  end
}
