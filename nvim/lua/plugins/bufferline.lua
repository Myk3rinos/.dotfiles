return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = "VeryLazy",
  config = function()
      diagnostics = "nvim_lspconfig",
        require('transparent').clear_prefix('BufferLine'),
    require("bufferline").setup({
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
        highlights = {
            -- fill = {
            --     guibg = {
            --         attribute = "bg",
            --         highlight = "BufferlineFill"
            --     },
            -- },
            background = {
                guibg = {
                    attribute = "bg",
                    highlight = "BufferlineBg"
                }
            },
            -- Buffers
            -- buffer_selected = {
            --     guibg = {
            --         attribute = "bg",
            --         highlight = "BufferlineBufferSelected"
            --     },
            --     guifg = {
            --         attribute = "fg",
            --         highlight = "BufferlineBufferSelected"
            --     },
            --     gui = "bold"
            -- },
            -- buffer_visible = {
            --     guibg = {
            --         attribute = "bg",
            --         highlight = "BufferlineBufferVisible"
            --     },
            --     guifg = {
            --         attribute = "fg",
            --         highlight = "BufferlineBufferVisible"
            --     }
            -- }
    },
        options = {
            -- get_element_icon = function(element)
            --     local custom_map = {toml: {icon = "[T]", hl}}
            -- end,
            -- separator_style = "slope",
            always_show_bufferline = false,    
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
        },
    })
  end
}
