-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- lazy.nvim not found, clone it
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", -- Optimize clone size
        "--branch=stable",    -- Use stable branch
        lazyrepo,
        lazypath,
    })

    -- Handle potential cloning errors
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

-- Prepend lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Set leader keys BEFORE loading plugins
-- This ensures that plugin mappings using these leader keys are correctly initialized.
vim.g.mapleader = " "         -- Global leader key (spacebar)
vim.g.maplocalleader = "\\"   -- Local leader key (backslash)

-- Load core configuration files
-- These files contain essential settings for Neovim's behavior and keybindings.
require("config.options")
require("config.keymaps")

-- Configure and initialize lazy.nvim
require("lazy").setup({
    -- Define plugin specifications
    spec = {
        -- Import plugin definitions from the 'plugins' directory
        -- This allows for organized plugin configurations in separate files.
        { import = "plugins" },
    },

    -- Lazy.nvim installation options
    install = {
        -- Default colorscheme to apply during plugin installation.
        -- This provides a consistent visual experience even when new plugins
        -- with default colorschemes are being installed.
        colorscheme = { "github_dark_default" },
    },

    -- Plugin update checker configuration
    checker = {
        -- Enable automatic checking for plugin updates.
        -- This helps keep your plugins up-to-date with the latest features and fixes.
        enabled = true,
    },

    -- Additional lazy.nvim configuration options can be added here.
    -- Refer to the official lazy.nvim documentation for all available options.
})