return {
  'nvim-lualine/lualine.nvim',
  config = function()
      -- local custom_dracula = require'lualine.themes.dracula'
      -- custom_dracula.normal.c.bg = '#111111'
    require('lualine').setup(
      
      {
      -- options = {
      --   theme = 'dracula'
      -- }
    })
  end
}
