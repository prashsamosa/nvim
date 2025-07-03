return {
    cmd = { 'bash-language-server', 'start' },
    root_markers = { '.git' },
    filetypes = { 'sh', 'bash' },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
}
