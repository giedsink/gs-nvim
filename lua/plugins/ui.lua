return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    component_separators = "|",
                    section_separators = "",
                },
            })
        end,
    },

    {
        "romgrk/barbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local k = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- Jump to buffer by position
            k("n", "t1", "<Cmd>BufferGoto 1<CR>", opts)
            k("n", "t2", "<Cmd>BufferGoto 2<CR>", opts)
            k("n", "t3", "<Cmd>BufferGoto 3<CR>", opts)
            k("n", "t4", "<Cmd>BufferGoto 4<CR>", opts)
            k("n", "t5", "<Cmd>BufferGoto 5<CR>", opts)

            -- Navigate and manage
            k("n", "tn", "<Cmd>BufferNext<CR>",         opts)
            k("n", "tp", "<Cmd>BufferPrevious<CR>",     opts)
            k("n", "td", "<Cmd>BufferDelete<CR>",       opts)
            k("n", "ts", "<Cmd>BufferMoveStart<CR>",    opts)

            -- Move current buffer to position
            local function move_to(target)
                local state = require("bufferline.state")
                local current = vim.fn.bufnr("%")
                local buffers = state.get().buffers
                local current_index
                for i, buf in ipairs(buffers) do
                    if buf.bufnr == current then
                        current_index = i
                        break
                    end
                end
                if not current_index then return end
                while current_index > target do
                    vim.cmd("BufferMovePrevious")
                    current_index = current_index - 1
                end
            end

            k("n", "tm1", function() move_to(1) end, opts)
            k("n", "tm2", function() move_to(2) end, opts)
            k("n", "tm3", function() move_to(3) end, opts)
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            local k = vim.keymap.set
            k("n", "<leader>e",  "<Cmd>Neotree toggle<CR>",     { desc = "Toggle file tree" })
            k("n", "<leader>o",  "<Cmd>Neotree reveal<CR>",     { desc = "Reveal file in tree" })
            k("n", "<leader>g",  "<Cmd>Neotree git_status<CR>", { desc = "Git changed files" })
            k("n", "<leader>nb", "<Cmd>Neotree buffers<CR>",    { desc = "Neotree buffers" })
            vim.api.nvim_set_hl(0, "NeotreeNormal", { bg = "none"})
            vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})
            vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none"})
            vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none"})
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end,
    },
}
