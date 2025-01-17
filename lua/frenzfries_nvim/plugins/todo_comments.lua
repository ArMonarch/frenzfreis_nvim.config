local todo_comments = {
	-- Highlight TODO, FIX, PERF, WARNING, NOTE, HACK, BUG in the codebase
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy", -- Sets the loading event to 'VimEnter'
	opts = {
		-- configuration comes here
		signs = false,
	},
}

-- Goto Prev TODO comment
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous TODO comment" })

-- Goto Next TODO comment
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })

-- Search through all project todos with Telescope
vim.keymap.set("n", "<leader>ft", function()
	vim.cmd("TodoTelescope")
end, { desc = "[F]ind [T]ODOs" })

return todo_comments
