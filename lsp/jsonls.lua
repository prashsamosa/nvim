return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    root_markers = { '.git' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = false,
    },
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
            format = { enable = false },
        },
    },
}
