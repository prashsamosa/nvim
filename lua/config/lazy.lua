-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", -- Optimize clone size.
    "--branch=stable",     -- Use the stable branch.
    lazyrepo,
    lazypath,
  })

  -- Handle cloning errors
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

-- Set leader keys before loading plugins
vim.g.mapleader = " "       -- Global leader key (spacebar)
vim.g.maplocalleader = "\\" -- Local leader key (backslash)

-- Load core configuration files
require("config.options")
require("config.keymaps")

-- Configure and initialize lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Import plugin configurations from the 'plugins' directory.
  },
  install = {
    colorscheme = { "github_dark_default" }, -- Default colorscheme during installation.
  },
  checker = {
    enabled = true, -- Enable automatic plugin update checks.
  },
  -- Additional lazy.nvim configuration options can be added here.
  -- Example:
  -- ui = {
  --   border = "rounded", -- Use rounded borders for lazy.nvim UI elements.
  -- },
})