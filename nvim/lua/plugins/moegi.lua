return {
    "inogai/moegi.nvim",
    name = "moegi",
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.cmd.colorscheme('moegi')

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
      local cursor_line = get_color('COLOR_CURSOR_LINE', '#00FF00')
      local git_add = get_color('COLOR_GIT_ADD', '#00FF00')
      local git_change = get_color('COLOR_GIT_CHANGE', '#FFA500')
      local git_delete = get_color('COLOR_GIT_DELETE', '#FF0000')
      local visual_bg = get_color('COLOR_VISUAL_BG', '#2a2a2a')

      -- Personnaliser les couleurs des numéros de ligne
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#808080' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = cursor_line, bold = true })

      -- Personnaliser la couleur de sélection visuelle
      vim.api.nvim_set_hl(0, 'Visual', { bg = visual_bg })
      vim.api.nvim_set_hl(0, 'VisualNOS', { bg = visual_bg })

      -- Personnaliser les couleurs de Snacks picker
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'FloatTitle', { fg = primary, bold = true })
      vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'SnacksPickerTitle', { fg = primary, bold = true })

      -- Personnaliser les couleurs de Telescope
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = primary, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = primary, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = primary, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = primary, bold = true })

      -- Personnaliser les couleurs de GitSigns
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = git_add })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = git_change })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = git_delete })
      vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#FF00FF' })
      vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = git_delete })
      vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = '#808080' })
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#606060', italic = true })

      -- Personnaliser les couleurs de Lazygit
      vim.api.nvim_set_hl(0, 'LazyGitBorder', { fg = primary })
      vim.api.nvim_set_hl(0, 'LazyGitFloat', { bg = 'NONE' })

      -- Personnaliser la couleur du séparateur de fenêtre (entre neo-tree et nvim)
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#212121' })
      vim.api.nvim_set_hl(0, 'VertSplit', { fg = primary })  -- Fallback pour anciennes versions

      -- Personnaliser les couleurs Git de Neo-tree
      vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = git_add })           -- Fichiers ajoutés
      vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#d4a520' })     -- Fichiers modifiés
      vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = git_delete })      -- Fichiers supprimés
      vim.api.nvim_set_hl(0, 'NeoTreeGitRenamed', { fg = primary })         -- Fichiers renommés
      vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#808080' })     -- Fichiers non trackés (gris)
      vim.api.nvim_set_hl(0, 'NeoTreeGitIgnored', { fg = '#404040' })       -- Fichiers ignorés (gris foncé)
      vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged', { fg = git_change })     -- Fichiers unstaged
      vim.api.nvim_set_hl(0, 'NeoTreeGitStaged', { fg = git_add })          -- Fichiers staged
      vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = '#FF0000', bold = true })  -- Conflits (rouge vif)
    end
}

