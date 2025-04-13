-- Bootstrap lazy.nvim
-- Define the path where lazy.nvim will be installed. This is typically
-- within Neovim's data directory.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed.
-- We use vim.uv.fs_stat (if available) or vim.loop.fs_stat to check if the
-- lazy.nvim directory exists.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- lazy.nvim is not installed, so we clone it from the official GitHub repository.
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    -- Use vim.fn.system to execute a shell command (git clone).
    -- --filter=blob:none: This optimization reduces the download size by not
    -- downloading the content of every file, only the necessary metadata.
    -- --branch=stable: This ensures we are using the stable branch of lazy.nvim.
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    -- Check if the git clone command was successful.
    if vim.v.shell_error ~= 0 then
        -- If there was an error during cloning, display an error message to the user.
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        -- Wait for the user to press a key before exiting.
        vim.fn.getchar()
        -- Exit Neovim with an error code.
        os.exit(1)
    end
end

-- Prepend the lazy.nvim path to Neovim's runtimepath.
-- This tells Neovim where to find the lazy.nvim plugin so it can be loaded.
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- The leader keys are used as prefixes for custom keybindings.
-- Setting them here ensures they are available when plugin keybindings are defined.
-- This is also a good place to setup other global settings (vim.opt).
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- Correctly set BEFORE lazy setup

-- Load the options configuration file.
-- This file likely contains settings defined using `vim.opt` to customize
-- Neovim's behavior (e.g., indentation, line numbers, etc.).
require("config.options")

-- Setup lazy.nvim
-- This is the core function call that initializes and configures the lazy.nvim
-- plugin manager.
require("lazy").setup({
    -- Define the plugin specifications.
    spec = {
        -- Import plugin definitions from the 'plugins' directory.
        -- This allows you to organize your plugin configurations into separate files
        -- within the 'lua/plugins' directory.
        { import = "plugins" },
    },
    -- Configure any other lazy.nvim settings here.
    -- See the official lazy.nvim documentation for a full list of available options.

    -- Configuration for plugin installation.
    install = {
        -- Default colorscheme to use when installing new plugins that might have
        -- a default colorscheme. This ensures a consistent look during installation.
        colorscheme = { "github_dark_default" },
    },

    -- Configuration for automatically checking for plugin updates.
    checker = {
        -- Enable automatic checking for plugin updates.
        enabled = true,
    },
})

-- Load the keymaps configuration file.
-- This file likely contains the custom keybindings defined using `vim.keymap.set`
-- to enhance Neovim's functionality and provide personalized shortcuts.
require("config.keymaps")