return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '▏',
      highlight = {
        "IblIndent1",
        "IblIndent2",
        "IblIndent3",
        "IblIndent4",
        "IblIndent5",
        "IblIndent6",
      },
    },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = false,
      highlight = {
        "IblScope1",
        "IblScope2",
        "IblScope3",
        "IblScope4",
        "IblScope5",
        "IblScope6",
      },
    },
    exclude = {
      filetypes = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
      },
    },
  },
  config = function(_, opts)
    -- Définir les couleurs personnalisées pour indent-blankline
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Couleurs pour les lignes d'indentation normales (plus subtiles)
      vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblIndent5", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblIndent6", { fg = "#909090" })

      -- Couleurs pour le scope actuel (plus visible)
      vim.api.nvim_set_hl(0, "IblScope1", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblScope2", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblScope3", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblScope4", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblScope5", { fg = "#383838" })
      vim.api.nvim_set_hl(0, "IblScope6", { fg = "#383838" })
      -- vim.api.nvim_set_hl(0, "IblScope1", { fg = "#FF6B9D" })
      -- vim.api.nvim_set_hl(0, "IblScope2", { fg = "#C792EA" })
      -- vim.api.nvim_set_hl(0, "IblScope3", { fg = "#82AAFF" })
      -- vim.api.nvim_set_hl(0, "IblScope4", { fg = "#7FD9E3" })
      -- vim.api.nvim_set_hl(0, "IblScope5", { fg = "#C3E88D" })
      -- vim.api.nvim_set_hl(0, "IblScope6", { fg = "#FFCB6B" })
    end)

    require("ibl").setup(opts)
  end,
}
