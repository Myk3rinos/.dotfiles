return {
  "windwp/nvim-ts-autotag",
  event = 'VeryLazy',
  config = function()
    require('nvim-ts-autotag').setup({
      autotag = { enable = true },
    })
  end
}
