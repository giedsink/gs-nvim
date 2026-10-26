return {
    {
        -- "master" branch supports Neovim 0.11; "main" needs 0.12+.
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "vim", "vimdoc", "query",
                    "javascript", "typescript", "tsx",
                    "json", "html", "css",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
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
