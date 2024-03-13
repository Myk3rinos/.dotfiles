return {
  "nvim-treesitter/nvim-treesitter", 
  -- "tree-sitter/tree-sitter-typescript",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "lua", "bash", "javascript", "html", "typescript", "css", "markdown", "yaml", "xml", "tsx", "scss", "html", "glsl", "csv", "tsx" },
      highlight = { enable = true },
      indent = { enable = true },  
      autotag = { enable = true },
    })
  end
}
