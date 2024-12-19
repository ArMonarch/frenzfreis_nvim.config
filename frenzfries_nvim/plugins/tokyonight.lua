local tokyonight = {
    "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            -- load the colorScheme here
            -- tokyonight-night
            -- tokyonight-day
            -- tokyonight-moon
            -- tokyonight-storm
            vim.cmd.colorscheme 'tokyonight-night'
            -- You can configure highlights by doing something like:
            vim.cmd.hi "Comment gui=none"
        end,
}

return tokyonight