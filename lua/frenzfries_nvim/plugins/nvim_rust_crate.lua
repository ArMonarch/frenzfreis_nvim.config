local nvim_rust_crate = {
	"saecki/crates.nvim",
	ft = { "toml" },
	config = function()
		require("crates").setup({
			completion = {
				cmp = {
					enabled = true,
				},
			},
		})
		require("cmp").setup.buffer({
			sources = { { name = "crates" } },
		})
	end,
}

return nvim_rust_crate
