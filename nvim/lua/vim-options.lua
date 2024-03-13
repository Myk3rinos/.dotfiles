vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.cmd("set number relativenumber")
-- vim.cmd("se cursorline")
vim.cmd("set cursorline")
vim.cmd("set clipboard+=unnamedplus")

vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>', {})
vim.keymap.set('n', '<leader>nt', ':set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>', {})
vim.keymap.set('n', '<C-h>', ':Neotree filesystem toggle left<CR>', {})

vim.wo.fillchars = "eob: " -- hide tilde at the end of file
-- set fillchars=eob:\ 
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["*y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
-- vim.cmd(":Neotree filesystem reveal left")

---:set number--:set number-:set number
--
--:augroup numbertoggle
--:  autocmd!
--:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
--:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
----:augroup END
--
--------------- highlight line number
--se cursorline
--
--or
--
--
--hi CursorLineNR cterm=bold
--augroup CLNRSet
--    autocmd! ColorScheme * hi CursorLineNR cterm=bold
--augroup END
--
--
--
--------------------- auto open
--
--autocmd VimEnter * Neotree | wincmd p
