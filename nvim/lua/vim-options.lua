vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.cmd("set number relativenumber")
vim.cmd("set cursorline")
vim.cmd("set clipboard+=unnamedplus")

vim.keymap.set('n', '<C-g>', ':TagbarToggle<CR>', {})

vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>', {})
vim.keymap.set('n', '<C-h>', ':set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>', {})


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


hi_all = 0
vim.api.nvim_set_keymap("n", "<C-w>", "", {
    callback = function()
       if hi_all == 0 then
          vim.cmd("set laststatus=0")
          vim.cmd("set norelativenumber")
          vim.cmd("set nonumber")
          vim.cmd("set noshowmode")
          vim.cmd("set noshowcmd")
          vim.cmd("set nohidden")
          vim.cmd("set noruler")
          hi_all = 1
       else
          vim.cmd("set laststatus=2")
          vim.cmd("set relativenumber")
          vim.cmd("set number")
          vim.cmd("set showmode")
          vim.cmd("set showcmd")
          vim.cmd("set hidden")
          vim.cmd("set ruler")
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

