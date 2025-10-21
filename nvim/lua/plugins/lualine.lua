return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    priority = 10,
    config = function()
        -- Récupérer les couleurs depuis les variables d'environnement
        local function get_color(env_var, default)
          local color = vim.fn.getenv(env_var)
          if color ~= vim.NIL and color ~= '' then
            return color
          end
          return default
        end

        -- Variables avec fallback sur valeurs par défaut
        local primary = get_color('COLOR_PRIMARY', '#c792ea')
        local insert = get_color('COLOR_INSERT', '#00FF00')
        local visual = get_color('COLOR_VISUAL', '#FFA500')
        local command = get_color('COLOR_COMMAND', '#FF69B4')

        -- Créer un thème personnalisé basé sur carbonfox
        local custom_theme = require'lualine.themes.carbonfox'

        -- Remplacer les couleurs par défaut avec les variables d'environnement
        -- Mode normal
        custom_theme.normal.a.bg = primary
        custom_theme.normal.a.fg = '#000000'
        custom_theme.normal.b.fg = primary

        -- Mode insertion
        custom_theme.insert.a.bg = insert
        custom_theme.insert.a.fg = '#000000'
        custom_theme.insert.b.fg = insert

        -- Mode visuel
        custom_theme.visual.a.bg = visual
        custom_theme.visual.a.fg = '#000000'
        custom_theme.visual.b.fg = visual

        -- Mode commande
        if custom_theme.command then
            custom_theme.command.a.bg = command
            custom_theme.command.a.fg = '#000000'
            custom_theme.command.b.fg = command
        end

        require('lualine').setup({
              extensions = {'neo-tree', 'lazy'},
              options = {
                theme = custom_theme
              }
        })
    end
}
