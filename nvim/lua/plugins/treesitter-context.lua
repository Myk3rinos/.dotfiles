return {
  "nvim-treesitter/nvim-treesitter-context",
  version = "v1.0.0", -- Version stable compatible avec Neovim 0.9.x
  lazy = false,
  priority = 100,
  config = function()
    require'treesitter-context'.setup{
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
    }
  end
}
