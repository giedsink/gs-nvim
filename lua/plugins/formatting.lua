-- Formatters (prettier, stylua) are installed separately.
-- Run :MasonInstall prettier stylua inside nvim to install them.
return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript      = { "prettier" },
                    typescript      = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    css             = { "prettier" },
                    html            = { "prettier" },
                    json            = { "prettier" },
                    lua             = { "stylua" },
                },
                -- Uncomment to auto-format on save:
                -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
            })

            vim.keymap.set({ "n", "v" }, "<leader>cf", function()
                require("conform").format({ async = true, lsp_fallback = true })
            end, { desc = "Format file" })
        end,
    },
}
