vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.cmd("set cursorline")
vim.cmd("set clipboard+=unnamedplus")
--vim.cmd(":loadview")
vim.g.mapleader = " "
-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.number = true
-- vim.opt.relativenumber = true


vim.keymap.set('n', '<leader>ht', ':TagbarToggle<CR>', {})

vim.keymap.set('n', '<leader>hn', ':Neotree filesystem toggle left<CR>', {})
vim.keymap.set('n', '<leader>hh', ':set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>', {})


vim.opt.fillchars = { eob = ' ' } -- hide tilde at the end of file


-- vim.api.nvim_set_keymap("n", "<C-x>", "", {
--     callback = function()
--         local statusline = vim.o.statusline
--
--         require("lualine").hide({
--             place = { "statusline" },
--             unhide = statusline == "" or statusline == "%#Normal#",
--         })
--     end,
-- })

hi_tab = 0
vim.api.nvim_set_keymap("n", "<leader>hb", "", {
    callback = function()
       if hi_tab == 0 then
          vim.cmd("set showtabline=0")
          hi_tab = 1
       else
          vim.cmd("set showtabline=2")
          hi_tab = 0
       end 
    end,
})
hi_all = 0
vim.api.nvim_set_keymap("n", "<leader>ha", "", {
    callback = function()
       if hi_all == 0 then
          vim.cmd("set laststatus=0")
          vim.cmd("set norelativenumber")
          vim.cmd("set nonumber")
          vim.cmd("set noshowmode")
          vim.cmd("set noshowcmd")
          vim.cmd("set nohidden")
          vim.cmd("set noruler")
          vim.cmd("set showtabline=0")
          hi_all = 1
       else
          vim.cmd("set laststatus=2")
          vim.cmd("set relativenumber")
          vim.cmd("set number")
          vim.cmd("set showmode")
          vim.cmd("set showcmd")
          vim.cmd("set hidden")
          vim.cmd("set ruler")
          vim.cmd("set showtabline=2")
          hi_all = 0
       end 
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'Start loadview on buffer enter',
--   -- group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.cmd("set loadview")
--   end,
-- })
-- vim.api.nvim_create_autocmd('BufEnter',  { command = ":loadview" }) 
-- vim.api.nvim_create_autocmd('BufEnter',  { command = "set showtabline=0" }) 

vim.keymap.set('n', '<leader>vm', ':set foldmethod=marker<CR>', {})
vim.keymap.set('n', '<leader>vl', ':loadview<CR>', {})

-- {{{
  --test
  --vim.api.nvim_set_keymap("n", "<leader>mv", ":set foldmethod=marker<CR>", {})
-- }}}

