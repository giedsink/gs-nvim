return {
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({ check_ts = true })
            -- Close pairs automatically when confirming a completion
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({ enable_autocmd = false })
        end,
    },

    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("spectre").setup()
            local k = vim.keymap.set
            k("n", "<leader>S",  '<cmd>lua require("spectre").toggle()<CR>',                          { desc = "Toggle Spectre" })
            k("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',   { desc = "Search current word" })
            k("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>',                { desc = "Search current word" })
            k("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })
        end,
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
        end,
    },

    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                delay = 200,
                large_file_cutoff = 2000,
            })
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
            local k = vim.keymap.set
            k("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              { desc = "All diagnostics" })
            k("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
            k("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  { desc = "Location list" })
            k("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   { desc = "Quickfix list" })
        end,
    },

    -- Replaces easymotion — press s then two chars to jump anywhere on screen
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("flash").setup()
            local k = vim.keymap.set
            k({ "n", "x", "o" }, "s", function() require("flash").jump() end,            { desc = "Flash jump" })
            k({ "n", "x", "o" }, "S", function() require("flash").treesitter() end,      { desc = "Flash treesitter select" })
        end,
    },
}
