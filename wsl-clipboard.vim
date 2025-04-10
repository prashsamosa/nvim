if exists('g:loaded_wsl_clipboard')
  finish
endif
let g:loaded_wsl_clipboard = 1
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
  augroup WSLClipboard
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif
