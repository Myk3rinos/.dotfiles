return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
          -- local custom_dracula = require'lualine.themes.dracula'
          -- custom_dracula.normal.c.bg = '#111111'
        -- local my_extension = { sections = { lualine_a = {'mode'} }, filetypes = {'lua'} }
        require('lualine').setup({
              extensions = {'neo-tree', 'lazy'},
              options = {
                -- theme = 'dracula'
                theme = 'carbonfox'
                -- theme = 'oxocarbon'
              }
        })
    end
}
