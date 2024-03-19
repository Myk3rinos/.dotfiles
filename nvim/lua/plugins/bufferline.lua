return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = "VeryLazy",
  config = function()
      diagnostics = "nvim_lspconfig",
    require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
