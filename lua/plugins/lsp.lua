return {
    { "williamboman/mason.nvim", config = true },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "lua_ls", "cssls" },
                automatic_installation = true,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.enable({ "ts_ls", "lua_ls", "cssls", "jdtls" })

            -- Global diagnostic keymap — works regardless of LSP attach state
            vim.keymap.set("n", "<leader>lsd", function()
                vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
            end, { desc = "Line diagnostics" })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr, noremap = true, silent = true }
                    local k = vim.keymap.set
                    local tb = require("telescope.builtin")

                    k("n", "gd",          vim.lsp.buf.definition,                      opts)
                    k("n", "gD",          vim.lsp.buf.declaration,                     opts)
                    k("n", "<leader>ca",  vim.lsp.buf.code_action,                     opts)
                    k("n", "<F2>",        vim.lsp.buf.rename,                          opts)
                    k("n", "K",           vim.lsp.buf.hover,                           opts)
                    k("n", "grr",         tb.lsp_references,                           vim.tbl_extend("force", opts, { desc = "References" }))
                    k("n", "gi",          tb.lsp_implementations,                      vim.tbl_extend("force", opts, { desc = "Implementations" }))
                    k("n", "<leader>lf",  tb.lsp_references,                           vim.tbl_extend("force", opts, { desc = "LSP references" }))
                    k("n", "<leader>lsp", tb.lsp_definitions,                          vim.tbl_extend("force", opts, { desc = "LSP definitions" }))
                    k("n", "<leader>lst", tb.lsp_type_definitions,                     vim.tbl_extend("force", opts, { desc = "LSP type definitions" }))
                    k("n", "<leader>li",  tb.lsp_implementations,                      vim.tbl_extend("force", opts, { desc = "LSP implementations" }))
                end,
            })
        end,
    },
}
