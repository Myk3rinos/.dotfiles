return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = "VeryLazy",
  config = function()
      diagnostics = "nvim_lspconfig",
    require("bufferline").setup({
    })
  end
}
