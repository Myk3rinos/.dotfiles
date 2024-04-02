return {
  "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 100,
  config = function()
    vim.keymap.set( "n", "<leader>tt", ":TransparentToggle<CR>", {} )
    -- require("transparent").setup({
    --   enable = true,
    -- })
    -- vim.api.nvim_create_autocmd({"BufEnter"}, {
    --     pattern = "*",
    --     group = "Transparency",
    --     command = "TransparentToggle",
    --     -- callback = function()
    --     --     vim.cmd('TransparentToggle')
    --     -- end
    -- })
  end
}
