return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true
    },
   config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls",
          "bashls",

          "tsserver",
          "biome",
          "html",
          "cssls",
          "cssmodules_ls",
          "unocss",
          "taplo",
          "yamlls",
          "nil_ls",
          -- "rnix",
          -- -- "tailwindcss",
          -- "vtsls",
          -- "hydra_lsp",
          -- "pkgbuild_language_server",
          -- "lemminx",
          -- "glsl_analyzer",
          -- "quick_lint_js",
          -- "quick_lint_ts",
          -- "quick_lint_css",
          -- "quick_lint_scss",
          -- "quick_lint_html",
          -- "quick_lint_json",
          -- "quick_lint_yaml",
          -- "quick_lint_md",
          -- "quick_lint_toml",
          -- "quick_lint_nix",
          -- "quick_lint_sh",
          -- "quick_lint_bash",
          -- "quick_lint_dockerfile",

--<Down>        --  "quick_lint_js", 
--<Down>        -----------------------GLSL 
--<Down>        --  "glsl_analyzer",
--<Down>          ---------------------javascript
--<Down>          "biome",
--<Down>        --  "quick_lint_js",
--<Down>        --  "tailwindcss",
         -- "tsserver",
--<Down>        --  "vtsls",
--<Down>         -- "hydra_lsp",
--<Down>          -- -----------------------TOML
--<Down>          "taplo",
--<Down>          -------------------------YAML
--<Down>          "yamlls",
--<Down>          -----------------------XML
--<Down>          -- "lemminx",
--<Down>
--<Down>
--<Down>          -----------------------html
--<Down>          "html",
--<Down>          -----------------------CSS
--<Down>          "cssls",
--<Down>          "cssmodules_ls",
--<Down>          "unocss",
--<Down>          -------------------------Bash
--<Down>          "bashls",
--<Down>          -- "pkgbuild_language_server",
--<Down>          -------------------------NIX
--<Down>        --  "nil_ls",
--<Down>        --  "rnix",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.bashls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      -- lspconfig.editorconfig_checker.setup({
      --   capabilities = capabilities
      -- })
    --  lspconfig.tsserver.setup({
    --    capabilities = capabilities
    --  })
      lspconfig.biome.setup({
        capabilities = capabilities
      })
    --  lspconfig.vtsls.setup({
    --    capabilities = capabilities
    --  })

      lspconfig.html.setup({})

      lspconfig.cssls.setup({})
      lspconfig.cssmodules_ls.setup({})
      lspconfig.unocss.setup({})

      lspconfig.bashls.setup({})
      -- lspconfig.bashls.setup({})
      lspconfig.taplo.setup({})
      lspconfig.yamlls.setup({})

      --lspconfig.nil_ls.setup({})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
