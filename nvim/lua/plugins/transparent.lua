return {
  "xiyaowong/transparent.nvim",
  config = function()
    vim.keymap.set( "n", "<leader>tt", ":TransparentToggle<CR>", {} )
    -- require("transparent").setup({
    --   enable = true,
    -- })
  end
}
