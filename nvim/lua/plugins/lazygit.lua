return {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies =  {
        "nvim-telescope/telescope.nvim",
        -- "nvim-lua/plenary.nvim"
    },
    config = function()
        require("telescope").load_extension("lazygit")

        vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", {})
    end,
}
