-- INFO: OPTIONS
-- Options for nvim
vim.g.mapleader = " "

vim.opt.conceallevel = 3
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = ' ' } -- hide tilde at the end of file

-- require colorscheme
-- vim.cmd.colorscheme 'catppuccin-frappe'
-- vim.cmd('colorscheme catppuccin-frappe'
-- vim.cmd([[autocmd ColorScheme * highlight CursorLineNr cterm=bold term=bold gui=bold]])

-- vim.cmd.colorscheme 'catppuccin-frappe'
-- vim.cmd [[silent! colorscheme carbonfox]]
-- vim.cmd [[silent! colorscheme catppuccin-frappe]]

-- INFO: FUNCTIONS
-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- INFO: KEYMAPS
-- move keymaps
vim.keymap.set('x', '<leader>p', "\"_dP", {})

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {})
-- vim.keymap.set('v', '<leader><Down>', ":m '>+1<CR>gv=gv", {})
-- vim.keymap.set('v', '<leader><Up>', ":m '<-2<cr>gv=gv", {})
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--Fold Keymaps
vim.keymap.set('n', '<leader>vm', ':set foldmethod=marker<CR>', {})
vim.keymap.set('n', '<leader>vs', ':mkview<CR>', {})
vim.keymap.set('n', '<leader>vl', ':loadview<CR>', {})
-- vim.api.nvim_create_autocmd('BufEnter',  { command = ":loadview" }) 
-- vim.api.nvim_create_autocmd('BufEnter',  { command = "set showtabline=0" }) 

-- hide keymaps
vim.keymap.set('n', '<leader>ht', ':TagbarToggle<CR>', {})
vim.keymap.set('n', '<leader>hn', ':Neotree filesystem toggle left<CR>', {})
vim.keymap.set('n', '<leader>hh', ':set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>', {})

-- {{{ :Hide tabline function
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
-- }}}

-- {{{ :Hide all info function
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
-- }}}

-- Todo keymaps
-- {{{

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })

-- }}}


-- vim.keymap.set("n", "<leader>nl", function()
--   require("noice").cmd("last")
-- end)
--
-- vim.keymap.set("n", "<leader>nh", function()
--   require("noice").cmd("history")
-- end)
