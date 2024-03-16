return {
    {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set( "n", "<leader>go", ":Neorg workspace notes<CR>", {} )
      vim.keymap.set( "n", "<leader>g;", ":Neorg workspace dotfiles<CR>", {} )
      vim.keymap.set( "n", "<leader>gb", ":Neorg return<CR>", {} )
      vim.keymap.set( "n", "<leader>ws", ":Neorg generate-workspace-summary<CR>", {} )
      vim.keymap.set( "n", "<leader>hc", ":Neorg toc<CR>", {} )
      require("neorg").setup {
        load = {
          -- ["core.export.markdown"] = {
          --       extension = "md",
          --   },
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                demo = "~/notes",
                dotfiles = "~/org/dotfiles",
                notes = "~/org/notes",
              },
              default_workspace = "notes",
            },
          },
          ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    -- Unmaps any Neorg key from the `norg` mode
                    keybinds.unmap("norg", "n", "gtd")
                    keybinds.unmap("norg", "n", keybinds.leader .. "nn")

                    -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
                    keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                    keybinds.map("norg", "n", "gto", "<cmd>nvim ~/.dotfiles/configuration.nix<CR>")

                    -- Remap unbinds the current key then rebinds it to have a different action
                    -- associated with it.
                    -- The following is the equivalent of the `unmap` and `map` calls you saw above:
                    keybinds.remap("norg", "n", "gtd", "<cmd>pwd<CR>")

                    -- Sometimes you may simply want to rebind the Neorg action something is bound to
                    -- versus remapping the entire keybind. This remap is essentially the same as if you
                    -- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
                    -- keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")

                    -- Want to move one keybind into the other? `remap_key` moves the data of the
                    -- first keybind to the second keybind, then unbinds the first keybind.
                    -- keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>td")
                end,
            }
        }
        },
      }
    end,
  },
}
