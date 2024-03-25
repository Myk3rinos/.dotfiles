return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }
    dashboard.section.header.opts = {
        hl = "Keyword"
    }
    dashboard.section.mru.opts = {
        position = "center",    
        hl = "String"
    }
    dashboard.section.bottom_buttons.val = {{ type = "text", val = "Quick links", opts = { hl = "String", position = "left" }},
        dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
    }
    dashboard.section.top_buttons.val = {
        { type = "text", val = "Quick links", opts = { hl = "String", position = "left" }},
        { type = "padding", val = 1 },
        dashboard.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
        dashboard.button( "d", "󰨇   Dashboard" , ":Neorg workspace dashboard<CR>"),
        dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "f", "󰈞  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
        dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.vim<CR>"),
        dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button( "q", "󰗼  > Quit NVIM", ":qa<CR>"),
        dashboard.button("f", " " .. "Find files", ":Telescope find_files <CR>"),
        dashboard.button("p", " " .. "Select project", ":Telescope neovim-project history <CR>"),
        dashboard.button("t", " " .. "Change theme", ":ThemeSwitcher <CR>"),
        dashboard.button("n", " " .. "Neorg", ":Neorg workspace main <CR>"),
        dashboard.button("l", "󰚰 " .. "LazyUI", ":Lazy <CR>"),
        dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
    }

    local time = os.date("%H:%M")
    local v = vim.version()
    local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
    local stats = require("lazy").stats()
    local plugins_count = stats.loaded .. "/" .. stats.count
    local count = (math.floor(stats.startuptime * 100) / 100)
    local time = vim.fn.strftime("%H:%M:%S")
    local date = vim.fn.strftime("%d.%m.%Y")
    local line1 = " " .. plugins_count .. " plugins loaded in " .. count .. "ms"
    local line2 = "󰃭 " .. date .. "  " .. time

    dashboard.section.footer.val = {
        { type = "text", val = line1 , opts = { hl = "Type", position = "center" }},
        { type = "text", val = line2 , opts = { hl = "Include", position = "center" }},
        { type = "text", val = version , opts = { hl = "Keyword", position = "center" }},
        { type = "text",    val = "Quick links", opts = { hl = "AlphaFooter", position = "center" }},
        { type = "padding", val = 1 },
    }

    alpha.setup(dashboard.opts)
  end,
}
