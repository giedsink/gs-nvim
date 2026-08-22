return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local ensure_installed = {
                "lua", "vim", "vimdoc", "query",
                "javascript", "typescript", "tsx",
                "json", "html", "css",
            }
            local installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.tbl_filter(function(lang)
                return not vim.tbl_contains(installed, lang)
            end, ensure_installed)
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

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
