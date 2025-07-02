return {
    cmd = { 'gopls' },
    root_markers = { 'go.work', 'go.mod', '.git' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
            },
            staticcheck = true,
            gofumpt = true,
            codelenses = {
                generate = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            matcher = "Fuzzy",
            semanticTokens = true,
            directoryFilters = { "-.git", "-node_modules", "-vendor" },
        },
    },
}
