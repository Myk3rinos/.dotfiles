return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  opts = {
        -- add any options here
    },
    lazy = false,
    config = function()
        require('Comment').setup()
    end
}
