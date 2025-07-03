return {
    cmd = { 'svelteserver', '--stdio' },
    root_markers = { 'package.json', '.git' },
    filetypes = { 'svelte' },
    settings = {
        svelte = {
            plugin = {
                html = { completions = { enable = true, emmet = false } },
                svelte = { completions = { enable = true, emmet = false } },
                css = { completions = { enable = true, emmet = true } },
            },
        },
    },
}
