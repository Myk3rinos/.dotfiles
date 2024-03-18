return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = "VeryLazy",
  config = function()
      diagnostics = "nvim_lspconfig",
    require("bufferline").setup({
                  highlights = require("catppuccin.groups.integrations.bufferline").get()
    })
  end
}
