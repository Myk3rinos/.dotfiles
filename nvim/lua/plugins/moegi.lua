return { 
    "inogai/moegi.nvim",
    name = "moegi",
    priority = 1000, 
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.cmd.colorscheme('moegi')
    end
}
  