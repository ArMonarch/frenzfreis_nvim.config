-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- load all configs for vim (vim options, vim keymaps, vim global states)
require("frenzfries_nvim.config")

-- Highlight when yanking (copying) test
vim.api.nvim_create_autocmd ("TextYankPost", {
    desc = "Highlight when yankingn (Copying) Text",
    group = vim.api.nvim_create_augroup("frenzfries_yank_group", { clear = true }),
    callback = function ()
        vim.highlight.on_yank()
    end,
})

-- load all the plugins
require("lazy").setup({
    {
        -- Tokyo Night ColorScheme for the NeoVim
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            -- load the colorScheme here (tokyonight-night, tokyonight-day, tokyonight-moon, tokyonight-storm)
            vim.cmd.colorscheme 'tokyonight-moon'
            -- You can configure highlights by doing something like:
            vim.cmd.hi "Comment gui=none"
        end
    },
    {
        -- collection of various small independent plugins/ modules
        -- From https://github.com/echasnovski/mini.nvim
        "echasnovski/mini.nvim",
        event = "VimEnter",
        init = function ()
            -- mini.vim status line setup
            -- set use_icons to true if you have nerd fon
            require("mini.statusline").setup({use_icons = vim.g.have_nerd_font})

            --Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]parentheses
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()
        end
    },
    {
        -- Highlight TODO, FIX, PERF, WARNING, NOTE, HACK, BUG in the codebase
        "folke/todo-comments.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter' [Later]
        opts = {
            -- configuration comes here
            signs = false
        },
        init = function ()
            vim.keymap.set('n', "[t", function () require("todo-comments").jump_prev() end, {desc = "Previous TODO comment"})
            vim.keymap.set('n', "]t", function () require("todo-comments").jump_next() end, {desc = "Next TODO comment"})
        end
    },
    {
        -- Useful plugin to show you pending keybinds
        'folke/which-key.nvim',
        event = "VimEnter", -- Sets the loading event to 'VimEnter' [Later]
        opts = { mappings = vim.g.have_nerd_font }
    },
    {
        -- Highlight, Edit, and Navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = {"bash", "c", "cpp", "lua", "luadoc", "vim", "vimdoc", "markdown", "markdown_inline", "query", "html", "css", "javascript", "python", "rust"},
            -- auto_install languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } }
        }
    },
    {
        -- Useful for getting pretty icons, but requires a Nerd Font.
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        enabled = vim.g.have_nerd_font,
    },
    {
        -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        branch = "0.1.x",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        },
        init = function ()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- Telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`

            require('telescope').setup ({
                -- put default mappings / updates / etc. in here
                extensions = {
                    ["ui-select"] = {require("telescope.themes").get_dropdown()}
                }
            })

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf") 
            pcall(require("telescope").load_extension, "ui-select")

            -- see ':help telescope.builtin'
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set('n', "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set('n', "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set('n', "<leader>ss", builtin.builtin, { desc = "[S]earch [S]earch Telescope" })
            vim.keymap.set('n', "<leader>sw", builtin.grep_string, { desc = "[S]earch Current [W]ord" })
            vim.keymap.set('n', "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set('n', "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set('n', "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set('n', "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files ('.' for repeat)" })
            vim.keymap.set('n', "<leader><leader>", builtin.buffers, { desc = "[] Find existing buffers" })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾'},
                changedelete = { text = '~'}
            },
        },
    }
    },{
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
})
