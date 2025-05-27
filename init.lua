require("config.lazy")

-- ~/.config/nvim/init.lua or relevant lsp config file

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Add "Snacks" to the list of recognized globals
                globals = { "vim", "Snacks" },
            },
            -- other settings...
        },
    },
    -- other setup options...
})
