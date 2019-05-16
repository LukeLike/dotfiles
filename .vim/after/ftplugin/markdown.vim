if has('win32')
    nmap <leader>b :silent !md2pdf %<CR>
    nmap <leader>p :!start /b %<.pdf<CR>
endif

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal textwidth=79

