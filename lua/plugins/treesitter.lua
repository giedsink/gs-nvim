return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- Enable treesitter highlighting for every buffer that has a parser
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
    {
        -- Auto-closes and renames HTML/JSX tags.
        -- Requires parsers: :TSInstall html tsx typescript javascript
        -- Plugin self-initializes via plugin/nvim-ts-autotag.lua — no setup() needed.
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
