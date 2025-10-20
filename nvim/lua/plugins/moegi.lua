return {
    "inogai/moegi.nvim",
    name = "moegi",
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.cmd.colorscheme('moegi')

      -- Personnaliser les couleurs des numéros de ligne
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#808080' })           -- Numéros de ligne normaux (gris)
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#c792ea', bold = true })  -- Ligne actuelle (violet)

      -- Personnaliser la couleur de sélection visuelle (plus foncé)
      vim.api.nvim_set_hl(0, 'Visual', { bg = '#2a2a2a' })           -- Gris foncé pour la sélection
      vim.api.nvim_set_hl(0, 'VisualNOS', { bg = '#2a2a2a' })        -- Sélection sans focus

      -- Personnaliser les couleurs de Snacks picker
      -- FloatBorder est le groupe principal pour les bordures de fenêtres flottantes
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#c792ea' })      -- Bordure verte
      vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#c792ea', bold = true })  -- Titre vert

      -- Si Snacks utilise des groupes spécifiques, on les définit aussi
      vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = '#c792ea' })
      vim.api.nvim_set_hl(0, 'SnacksPickerTitle', { fg = '#c792ea', bold = true })

      -- Personnaliser les couleurs de Telescope
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#c792ea' })           -- Bordure principale
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#c792ea' })     -- Bordure du prompt
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#c792ea' })    -- Bordure des résultats
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#c792ea' })    -- Bordure de la preview
      vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = '#c792ea', bold = true })  -- Titre
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#c792ea', bold = true })  -- Titre du prompt
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#c792ea', bold = true }) -- Titre des résultats
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#c792ea', bold = true }) -- Titre de la preview
    end
}
  
