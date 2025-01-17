local opt = vim.opt

-- enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- sync clipboard between OS and neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- tab / indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true

-- decrease update time
opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- search
opt.incsearch = true
opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
opt.ignorecase = true
opt.smartcase = true

-- Apperance
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.breakindent = true
-- Sets how neovim will display certain whitespace characters in the editor.
-- opt.listchars = { tab = "» ", trail = ".", nbsp = "␣" }
opt.list = true
opt.cursorline = true
opt.cmdheight = 1
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 6
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Behaviour
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true
opt.inccommand = "split"
