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
        callout = {
        -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
        -- | rendered   | replaces the 'raw' value when rendering                             |
        -- | highlight  | highlight for the 'rendered' text and quote markers                 |
        -- | quote_icon | optional override for quote.icon value for individual callout       |
        -- | category   | optional metadata useful for filtering                              |

        note      = { raw = '[!NOTE]',      rendered = '󰋽 Note',      highlight = 'RenderMarkdownInfo',    category = 'github'   },
        tip       = { raw = '[!TIP]',       rendered = '󰌶 Tip',       highlight = 'RenderMarkdownSuccess', category = 'github'   },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint',    category = 'github'   },
        warning   = { raw = '[!WARNING]',   rendered = '󰀪 Warning',   highlight = 'RenderMarkdownWarn',    category = 'github'   },
        caution   = { raw = '[!CAUTION]',   rendered = '󰳦 Caution',   highlight = 'RenderMarkdownError',   category = 'github'   },
        -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
        abstract  = { raw = '[!ABSTRACT]',  rendered = '󰨸 Abstract',  highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        summary   = { raw = '[!SUMMARY]',   rendered = '󰨸 Summary',   highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        tldr      = { raw = '[!TLDR]',      rendered = '󰨸 Tldr',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        info      = { raw = '[!INFO]',      rendered = '󰋽 Info',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        todo      = { raw = '[!TODO]',      rendered = '󰗡 Todo',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
        hint      = { raw = '[!HINT]',      rendered = '󰌶 Hint',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        success   = { raw = '[!SUCCESS]',   rendered = '󰄬 Success',   highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        check     = { raw = '[!CHECK]',     rendered = '󰄬 Check',     highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        done      = { raw = '[!DONE]',      rendered = '󰄬 Done',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        question  = { raw = '[!QUESTION]',  rendered = '󰘥 Question',  highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        help      = { raw = '[!HELP]',      rendered = '󰘥 Help',      highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        faq       = { raw = '[!FAQ]',       rendered = '󰘥 Faq',       highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
        failure   = { raw = '[!FAILURE]',   rendered = '󰅖 Failure',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
        fail      = { raw = '[!FAIL]',      rendered = '󰅖 Fail',      highlight = 'RenderMarkdownError',   category = 'obsidian' },
        missing   = { raw = '[!MISSING]',   rendered = '󰅖 Missing',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
        danger    = { raw = '[!DANGER]',    rendered = '󱐌 Danger',    highlight = 'RenderMarkdownError',   category = 'obsidian' },
        error     = { raw = '[!ERROR]',     rendered = '󱐌 Error',     highlight = 'RenderMarkdownError',   category = 'obsidian' },
        bug       = { raw = '[!BUG]',       rendered = '󰨰 Bug',       highlight = 'RenderMarkdownError',   category = 'obsidian' },
        example   = { raw = '[!EXAMPLE]',   rendered = '󰉹 Example',   highlight = 'RenderMarkdownHint' ,   category = 'obsidian' },
        quote     = { raw = '[!QUOTE]',     rendered = '󱆨 Quote',     highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        cite      = { raw = '[!CITE]',      rendered = '󱆨 Cite',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
        },
        indent = {
            -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
            -- level of the heading. Indenting starts from level 2 headings onward by default.

        -- Turn on / off org-indent-mode.
        enabled = false,
        -- Additional modes to render indents.
        render_modes = false,
        -- Amount of additional padding added for each heading level.
        per_level = 2,
        -- Heading levels <= this value will not be indented.
        -- Use 0 to begin indenting from the very first level.
        skip_level = 1,
        -- Do not indent heading titles, only the body.
        skip_heading = false,
        -- Prefix added when indenting, one per level.
        icon = '▎',
        -- Priority to assign to extmarks.
        priority = 0,
        -- Applied to icon.
            highlight = 'RenderMarkdownIndent',
        },
            checkbox = {
        -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
        -- There are two special states for unchecked & checked defined in the markdown grammar.

        -- Turn on / off checkbox state rendering.
        enabled = true,
        -- Additional modes to render checkboxes.
        render_modes = false,
        -- Render the bullet point before the checkbox.
        bullet = false,
        -- Padding to add to the left of checkboxes.
        left_pad = 0,
        -- Padding to add to the right of checkboxes.
        right_pad = 1,
        unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'.
            icon = '󰄱 ',
            -- Highlight for the unchecked icon.
            highlight = 'RenderMarkdownUnchecked',
            -- Highlight for item associated with unchecked checkbox.
            scope_highlight = nil,
        },
        checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'.
            icon = '󰱒 ',
            -- Highlight for the checked icon.
            highlight = 'RenderMarkdownChecked',
            -- Highlight for item associated with checked checkbox.
            scope_highlight = nil,
        },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
        -- Priority to assign to scope highlight.
        scope_priority = nil,
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

                -- Exécuter un bloc de code bash avec Ctrl+o
                vim.keymap.set('n', '<C-o>', function()
                    -- Obtenir le node sous le curseur
                    local node = vim.treesitter.get_node()
                    if not node then
                        vim.cmd('normal! <C-o>')
                        return
                    end

                    -- Chercher le parent qui est un code_fence_content
                    while node do
                        local node_type = node:type()
                        if node_type == 'fenced_code_block' then
                            -- Vérifier si c'est du bash
                            local info_string = vim.treesitter.get_node_text(node:child(1), 0)
                            if info_string:match('bash') or info_string:match('sh') then
                                -- Extraire le contenu du code
                                local code_node = node:child(3) -- code_fence_content
                                if code_node then
                                    local code = vim.treesitter.get_node_text(code_node, 0)

                                    -- Créer un fichier temporaire pour éviter les problèmes d'échappement
                                    local tmpfile = vim.fn.tempname() .. '.sh'
                                    local f = io.open(tmpfile, 'w')
                                    if f then
                                        f:write(code)
                                        f:write('\nread -p "Appuyez sur Entrée pour fermer..."')
                                        f:close()
                                    end

                                    -- Exécuter le code bash
                                    vim.cmd('new') -- Nouvelle fenêtre
                                    vim.cmd('term bash ' .. tmpfile)
                                    vim.cmd('startinsert')

                                    -- Nettoyer le fichier temporaire après fermeture
                                    vim.api.nvim_create_autocmd('TermClose', {
                                        buffer = vim.api.nvim_get_current_buf(),
                                        callback = function()
                                            os.remove(tmpfile)
                                        end,
                                        once = true,
                                    })
                                    return
                                end
                            end
                            break
                        end
                        node = node:parent()
                    end

                    -- Si pas dans un bloc bash, comportement normal (retour arrière)
                    vim.cmd('normal! ')
                end, { buffer = true, desc = 'Exécuter le bloc bash ou retour arrière' })
            end,
        })
    end,
}
