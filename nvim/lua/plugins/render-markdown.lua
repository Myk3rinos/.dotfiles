return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    lazy = false,  -- Force immediate loading
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Enable all features for debugging
        file_types = { 'markdown' },
        render_modes = true,  -- Render in all modes
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
        link = {
            -- Turn on / off inline link icon rendering.
            enabled = true,
            -- Additional modes to render links.
            render_modes = true,  -- Render in all modes
            -- How to handle footnote links, start with a '^'.
            footnote = {
                -- Turn on / off footnote rendering.
                enabled = true,
                -- Inlined with content.
                icon = '󰯔 ',
                -- Replace value with superscript equivalent.
                superscript = true,
                -- Added before link content.
                prefix = '',
                -- Added after link content.
                suffix = '',
            },
            -- Inlined with 'image' elements.
            image = '󰥶 ',
            -- Inlined with 'email_autolink' elements.
            email = '󰀓 ',
            -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
            hyperlink = '󰌹 ',
            -- Applies to the inlined icon as a fallback.
            highlight = 'RenderMarkdownLink',
            -- Applies to WikiLink elements.
            wiki = {
                icon = '󱗖 ',
                body = function()
                    return nil
                end,
                highlight = 'RenderMarkdownWikiLink',
                scope_highlight = nil,
            },
            -- Define custom destination patterns so icons can quickly inform you of what a link
            -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
            -- patterns match a link the one with the longer pattern is used.
            -- The key is for healthcheck and to allow users to change its values, value type below.
            -- | pattern   | matched against the destination text                            |
            -- | icon      | gets inlined before the link text                               |
            -- | kind      | optional determines how pattern is checked                      |
            -- |           | pattern | @see :h lua-patterns, is the default if not set       |
            -- |           | suffix  | @see :h vim.endswith()                                |
            -- | priority  | optional used when multiple match, uses pattern length if empty |
            -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
            custom = {
                web = { pattern = '^http', icon = '󰖟 ' },
                web = { pattern = '^https', icon = '󰖟 ' },
                discord = { pattern = 'discord%.com', icon = '󰙯 ' },
                github = { pattern = 'github%.com', icon = '󰊤 ' },
                gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
                google = { pattern = 'google%.com', icon = '󰊭 ' },
                neovim = { pattern = 'neovim%.io', icon = ' ' },
                reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
                stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
                wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
                youtube = { pattern = 'youtube%.com', icon = '󰗃 ' },
            },
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

        -- Keymap pour suivre les liens Markdown
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'markdown',
            callback = function()
                -- Utiliser gf pour suivre les liens avec Enter
                vim.keymap.set('n', '<CR>', function()
                    -- Vérifier si le curseur est sur un lien
                    local node = vim.treesitter.get_node()
                    if node then
                        local node_type = node:type()
                        -- Si c'est un lien markdown
                        if node_type:match('link') or node_type:match('uri') then
                            vim.cmd('normal! gf')
                            return
                        end
                    end
                    -- Sinon, comportement normal de Enter
                    vim.cmd('normal! o')
                end, { buffer = true, desc = 'Suivre le lien ou nouvelle ligne' })

                -- Ouvrir le lien dans une nouvelle fenêtre avec Ctrl+Enter
                vim.keymap.set('n', '<C-CR>', 'gf', { buffer = true, desc = 'Ouvrir le lien' })

                -- Retour arrière avec Ctrl+o
                vim.keymap.set('n', '<C-o>', '<C-o>', { buffer = true, desc = 'Retour arrière' })
            end,
        })
    end,
}
