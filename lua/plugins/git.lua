return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<leader>lg", "<Cmd>LazyGit<CR>", { desc = "LazyGit" })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs = require("gitsigns")
            gs.setup({
                signs = {
                    add          = { text = "+" },
                    change       = { text = "~" },
                    delete       = { text = "-" },
                    topdelete    = { text = "0" },
                    changedelete = { text = "~" },
                },
                current_line_blame = false,
                on_attach = function(bufnr)
                    local k = vim.keymap.set
                    local opts = { buffer = bufnr }

                    -- Navigate hunks
                    k("n", "]c", function() gs.next_hunk() end, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
                    k("n", "[c", function() gs.prev_hunk() end, vim.tbl_extend("force", opts, { desc = "Prev hunk" }))

                    -- Preview, stage, reset
                    k("n", "<leader>hp", gs.preview_hunk,        vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
                    k("n", "<leader>hs", gs.stage_hunk,          vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
                    k("n", "<leader>hr", gs.reset_hunk,          vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
                    k("n", "<leader>hb", gs.blame_line,          vim.tbl_extend("force", opts, { desc = "Blame line" }))
                    k("n", "<leader>hd", gs.diffthis,            vim.tbl_extend("force", opts, { desc = "Diff this file" }))
                end,
            })
        end,
    },
}
