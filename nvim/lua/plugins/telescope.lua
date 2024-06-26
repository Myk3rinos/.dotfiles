return {
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  event = 'VeryLazy',
    lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('transparent').clear_prefix('telescope')

    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    -- vim.keymap.set('n', '<leader>st', builtin.git_files, { desc = '[S]earch [T]racked files' }) 


    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config'}
    end, { desc = '[S]earch [N]vim config' })

    -- vim.keymap.set('n', '<leader>st', { cwd = TodoTelescope keywords=TODO,FIX}, { desc = '[S]earch [T]odo tags' })
    
    vim.keymap.set("n", "<leader>sn", ":TodoTelescope keywords=TODO,FIX<CR>", {})

  end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
