-- Native Neovim 0.11+ LSP config for emmet_ls
return {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = {
    'html',
    'css',
    'scss',
    'sass',
    'less',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'vue'
  },
  root_markers = { '.git' },
}
