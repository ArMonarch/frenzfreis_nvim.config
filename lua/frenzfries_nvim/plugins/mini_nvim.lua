local mini_nvim = {
	-- collection of various small independent plugins/ modules
	-- From https://github.com/echasnovski/mini.nvim
	"echasnovski/mini.nvim",
	event = "VimEnter",
	config = function()
		-- mini.vim status line setup
		-- set use_icons to true if you have nerd fon
		require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })

		--Better Around/Inside textobjects
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]parentheses
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Comment lines
		require("mini.comment").setup()

		-- Using autopairs form nvim_autopairs
		-- -- Minimal and fast autopairs from mini.nvim
		-- -- require("mini.pairs").setup()
	end,
}

return mini_nvim
