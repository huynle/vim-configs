" for termdebug
packadd termdebug
let g:termdebug_wide=1

" use for sending commands to gdb
" map ,w :call TermDebugSendCommand('where')<CR>

" nnoremap <Leader>td :Termdebug %:r<CR><c-w>2j<c-w>L

autocmd FileType cpp
  \ nnoremap <Leader>td :Termdebug %:r<CR>
  " \ | nnoremap <F9> :Break<CR>
  " \ | nnoremap <S-F9> :Clear<CR>
  " \ | nnoremap <F5> :Continue<CR>
  " \ | nnoremap <S-F5> :Stop<CR>
  " \ | nnoremap <F10> :Over<CR>
  " \ | nnoremap <F11> :Step<CR>
  " \ | nnoremap <S-F11> :Finish<CR>
  " \ | nnoremap <RightMouse> :Break<CR>


autocmd FileType python
  \ nnoremap <Leader>td :GdbStartPDB python3 -m pdb %:p
