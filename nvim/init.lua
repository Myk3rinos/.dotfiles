local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
--require("lazy").setup(plugins, opts)
require("vim-options")
require("lazy").setup("plugins")
--require("lazy").setup()

-- NOTE: This is a temporary fix for the issue with the lazy.nvim plugin
--{{{
--  require("lazy").setup({
-- require("lazy").setup({
--}}}  

-- {{{
-- require("nightfox").setup({
--   fox = "carbonfox",
--   styles = {
--     comments = "italic",
--     functions = "italic",
--     keywords = "italic",
--     strings = "italic",
--     variables = "italic",
--   },
--   colors = {
--     fg = "#d8dee9",
--     bg = "#2e3440",
--     black = "#3b4252",
--     red = "#bf616a",
--     green = "#a3be8c",
--     yellow = "#ebcb8b",
--     blue = "#81a1c1",
--     purple = "#b48ead",
--     cyan = "#88c0d0",
--     white = "#e5e9f0",
--     orange = "#d08770",
--     pink = "#5e81ac",
--     lightbg = "#4c566a",
--   },
--   background = none,
--   transparent_background = true,
--   integrations = {
--     treesitter = true,
--     neotree = true,
--     -- native_lsp = {
--     --   enabled = true,
--     --   virtual_text = {errors = "italic", hints = "italic", warnings = "italic", information = "italic"},
--     --   underlines = {errors = "underline", hints = "underline", warnings = "underline", information = "underline"}
--     -- },
--     -- lsp_trouble = false,
--     -- lsp_saga = false,
--     -- gitgutter = false,
--     -- gitsigns = true,
--     -- telescope = true,
--     -- nvimtree = {enabled = true, show_root = true},
--     -- which_key = true,
--     -- indent_blankline = {enabled = true, colored_indent_levels = true},
--     -- dashboard = true,
--     -- neogit = false,
--     -- vim_sneak = false,
--     -- fern = false,
--     -- barbar = false,
--     -- bufferline = true,
--     -- markdown = false,
--     -- lightspeed = false,
--     -- ts_rainbow = true,
--     -- hop = false
--   }
-- })
-- }}}
------------------------
