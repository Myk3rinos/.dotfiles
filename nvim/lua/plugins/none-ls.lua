return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.biome,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.prettierd,
         -- null_ls.builtins.diagnostics.eslint_d,
         -- null_ls.builtins.diagnostics.oxlint,
         -- null_ls.builtins.diagnostics.quick_lint_js,
         -- null_ls.builtins.formatting.ts-standard,
         -- null_ls.builtins.formatting.htmlbeautifier,
         -- null_ls.builtins.diagnostics.eslint,
         -- null_ls.builtins.completion.spell,
      }
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end
}
