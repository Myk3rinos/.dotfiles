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
-- vim.keymap.set('n', '<C-h>', ':set laststatus=0<CR>', {})
vim.keymap.set('n', '<C-h>', ':set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>', {})
-- vim.keymap.set('n', '<C-h>', ':Neotree filesystem toggle left<CR>', {})


--NOTE you can...

vim.opt.fillchars = { eob = ' ' } -- hide tilde at the end of file


vim.api.nvim_set_keymap("n", "<C-x>", "", {
    callback = function()
        local statusline = vim.o.statusline

        require("lualine").hide({
            place = { "statusline" },
            unhide = statusline == "" or statusline == "%#Normal#",
        })
    end,
})

        hi_all = 0
vim.api.nvim_set_keymap("n", "<C-w>", "", {
    callback = function()
       if hi_all == 0 then
          vim.cmd("set laststatus=0")
          -- vim.crd("set relativenumber")
          -- vim.cmd("set number")
          -- vim.cmd("set showmode")
          -- vim.cmd("set showcmd")
          -- vim.cmd("set hidden")
          -- vim.cmd("set ruler")
          hi_all = 1
       else
          vim.cmd("set laststatus=2")
          -- vim.cmd("set norelativenumber")
          -- vim.cmd("set nonumber")
          -- vim.cmd("set noshowmode")
          -- vim.cmd("set noshowcmd")
          -- vim.cmd("set nohidden")
          -- vim.cmd("set noruler")
          hi_all = 0
       end 
    end,
})
-- vim.opt.h1search = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
--autocmd VimEnter * Neotree | wincmd
