return {
    cmd = { 'typescript-language-server', '--stdio' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    init_options = {
        preferences = { disableSuggestions = true },
    },
    settings = {
        typescript = {
            format = { enable = false },
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            format = { enable = false },
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
}
