local which_keys = {
	-- Useful plugin to show you pending keybinds
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter' [Later]
	opts = { mappings = vim.g.have_nerd_font },
}

return which_keys
