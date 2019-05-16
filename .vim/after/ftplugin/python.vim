if has('win32')
    noremap <leader>b :AsyncRun activate luke_env && python %<CR>
else
    noremap <leader>b :AsyncRun python %<CR>
endif
