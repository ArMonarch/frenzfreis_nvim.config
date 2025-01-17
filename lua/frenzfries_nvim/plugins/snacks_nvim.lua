-- Each generation Best Pokemon
local Pokemon_Table = {

	-- Gen 1 Legendary Pokemon
	"articuno",
	"zapdos",
	"moltres",
	"mewtwo",

	-- Gen 2 Legendary Pokemon
	"lugia",
	"ho-oh",
	"raikou",
	"entei",
	"suicune",

	-- Gen 3 Legendary Pokemon
	"regirock",
	"regice",
	"registeel",
	"latias",
	"latios",
	"kyogre",
	"groudon",
	"rayquaza",

	-- Gen 4 Legendary Pokemon
	"uxie",
	"mesprit",
	"azelf",
	"dialga",
	"palkia",
	"heatran",
	"regigigas",
	"giratina",
	"cresselia",

	-- Gen 5 Legendary Pokemon
	"cobalion",
	"terrakion",
	"virizion",
	"tornadus",
	"thundurus",
	"reshiram",
	"zekrom",
	"landorus",
	"kyurem",

	--  Gen 6 Legendary Pokemon
	"xerneas",
	"yveltal",
	"zygarde",

	-- Gen 7 Legendary Pokemon
	"type-null",
	"silvally",
	"tapu-koko",
	"tapu-lele",
	"tapu-bulu",
	"tapu-fini",
	"cosmog",
	"cosmoem",
	"solgaleo",
	"lunala",
	"necrozma",

	-- Gen 8 Legendary Pokemon
	"zacian",
	"zamazenta",
}
local Pokemon_List = ""
for _, Pokemon in ipairs(Pokemon_Table) do
	Pokemon_List = Pokemon_List .. Pokemon .. ","
end

if #Pokemon_List > 0 then
	Pokemon_List = Pokemon_List:sub(1, -2)
end

-- cmd command to summon pokemon
local Pokemon_Cmd = "pokemon-colorscripts -rn %s --no-title; sleep .1"

local snacks_nvim = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below

		-- Featured Dashboard
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					cmd = string.format(Pokemon_Cmd, Pokemon_List),
					random = 1500,
					pane = 2,
					indent = 8,
					padding = 1,
					height = 25,
				},
			},
		},

		-- prevents LSP and Treesitter attaching to the buffer for file size > 2MB
		bigfile = { enabled = true, size = 2 * 1024 * 1024 },

		-- Visualize indent guides and scopes based on treesitter or indent
		indent = { enabled = true },

		-- Pretty vim.notify
		notifier = { enabled = true, style = "compact" },

		-- When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.
		quickfile = { enabled = true },

		-- Smooth scrolling for Neovim
		scroll = { enabled = true },
	},
}

return snacks_nvim
