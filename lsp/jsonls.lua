-- Native Neovim 0.11+ LSP config for jsonls
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git', 'package.json' },
  init_options = {
    provideFormatter = true,
  },
}
