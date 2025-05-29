require("config.lazy")

-- ~/.config/nvim/init.lua or relevant lsp config file

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "Snacks" },
            },
        },
    },
})
