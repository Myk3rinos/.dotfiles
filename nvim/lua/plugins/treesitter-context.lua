return {
  "nvim-treesitter/nvim-treesitter-context",
  commit = "b219328", -- Early 2024 commit, before LspRequest event was added
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
