if has('win32')
    noremap <localleader>bb :AsyncRun -raw activate luke_env && python %<CR>
else
    noremap <localleader>bb :AsyncRun -raw python3 %<CR>
endif

noremap <localleader>tt :TmuxRun python3 %<CR>

let $PYTHONUNBUFFERED = 1
