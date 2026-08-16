return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function(_)
    require 'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "javascript", "typescript", "go", "c", "cpp", "lua",
        "query" },

      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-x>",           -- set to `false` to disable one of the mappings
          node_incremental = "<C-Up>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-Down>",
        },
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["aa"] = "@assignment.outer",
            ["ia"] = "@assignment.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ab"] = "@parameter.outer",
            ["ib"] = "@parameter.inner",
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<C-Right>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<C-Left>"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,           -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = { query = "@parameter.outer", desc = "Next class start" },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            ["]i"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          -- goto_next_end = {
          --     ["]M"] = "@function.outer",
          --     ["]["] = "@class.outer",
          -- },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@parameter.outer",
            ["[i"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
          },
          -- goto_previous_end = {
          --     ["[M"] = "@function.outer",
          --     ["[]"] = "@class.outer",
          -- },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
        },
      },
    }
  end
}
