return {
    cmd = { 'yaml-language-server', '--stdio' },
    root_markers = { '.git' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
    settings = {
        yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
            format = { enable = false },
            validate = true,
            hover = true,
            completion = true,
        },
    },
}
