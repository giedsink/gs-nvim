return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    preview = { treesitter = false },
                    wrap_results = true,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.97,
                        height = 0.95,
                        preview_width = 0.60,
                    },
                },
            })

            -- Telescope hardcodes wrap=false on the preview window; force it back on
            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function()
                    vim.opt_local.wrap = true
                end,
            })

            local builtin = require("telescope.builtin")
            local k = vim.keymap.set
            k("n", "<leader>ff", builtin.find_files,  { desc = "Find files" })
            k("n", "<leader>fw", builtin.live_grep,   { desc = "Find word" })
            k("n", "<leader>fb", builtin.buffers,     { desc = "Find buffers" })
            k("n", "<leader>fh", builtin.help_tags,   { desc = "Help tags" })
            k("n", "<leader>fr", builtin.oldfiles,    { desc = "Recent files" })
            k("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
        end,
    },
}
