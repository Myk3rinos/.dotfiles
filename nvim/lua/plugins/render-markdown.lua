return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        heading = {
            -- Activer l'icône et le fond pour les titres
            enabled = true,
            sign = true,
            icons = { '󰎤 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        },
        code = {
            -- Style pour les blocs de code
            enabled = true,
            sign = true,
            style = 'full',
            left_pad = 2,
            right_pad = 2,
        },
        bullet = {
            -- Icônes pour les listes
            enabled = true,
            icons = { '●', '○', '◆', '◇' },
        },
    },
    config = function(_, opts)
        -- Définir les couleurs personnalisées pour render-markdown
        local colors = {
            -- Couleurs pour les titres (H1 à H6)
            h1 = '#FF6B9D',  -- Rose vif
            h2 = '#C792EA',  -- Violet
            h3 = '#82AAFF',  -- Bleu
            h4 = '#7FD9E3',  -- Cyan
            h5 = '#C3E88D',  -- Vert
            h6 = '#FFCB6B',  -- Jaune/Orange

            -- Couleurs pour les blocs de code
            code_bg = '#2A2A2A',      -- Fond gris foncé
            code_border = '#404040',   -- Bordure grise

            -- Autres éléments
            quote = '#7FD9E3',         -- Cyan pour les citations
            bullet = '#C792EA',        -- Violet pour les puces
        }

        -- Appliquer les highlights pour les titres
        vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = colors.h1, bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = colors.h2, bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = colors.h3, bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = colors.h4, bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = colors.h5, bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = colors.h6, bold = true })

        -- Highlights pour les backgrounds des titres
        vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = colors.h1, fg = '#000000' })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = colors.h2, fg = '#000000' })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = colors.h3, fg = '#000000' })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = colors.h4, fg = '#000000' })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = colors.h5, fg = '#000000' })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = colors.h6, fg = '#000000' })

        -- Highlights pour les blocs de code
        vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = colors.code_bg })
        vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = colors.code_bg, fg = '#C3E88D' })

        -- Highlights pour les citations
        vim.api.nvim_set_hl(0, 'RenderMarkdownQuote', { fg = colors.quote, italic = true })

        -- Highlights pour les puces et listes
        vim.api.nvim_set_hl(0, 'RenderMarkdownBullet', { fg = colors.bullet })

        -- Highlights pour les liens
        vim.api.nvim_set_hl(0, 'RenderMarkdownLink', { fg = colors.h3, underline = true })

        -- Highlights pour le texte en gras et italique
        vim.api.nvim_set_hl(0, 'RenderMarkdownBold', { bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownItalic', { italic = true })

        require('render-markdown').setup(opts)
    end,
}
