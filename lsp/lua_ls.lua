return {
    cmd = { 'lua-language-server' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                maxPreload = 100,
                preloadFileSize = 1000,
                ignoreDir = { ".git", "node_modules", ".vscode", "target", "build", "dist" },
                library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
            },
            diagnostics = {
                globals = { "vim", "Snacks", "require", "pcall", "pairs", "ipairs" },
                disable = { "missing-fields", "incomplete-signature-doc" },
            },
            completion = { callSnippet = "Replace" },
            hint = { enable = true },
            telemetry = { enable = false },
            format = { enable = false },
        },
    },
}
