return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { "rose-pine/neovim",      name = "rose-pine", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
}
