""""""" vim-autoformat
" needs to be absolute path
let g:formatterpath = [expand('~/.pyenv/versions/neovim/bin')]

" get some verbose
" let g:autoformat_verbosemode=1

" yapf works for ranges too
let g:formatter_yapf_style = 'pep8'
let g:formatters_python = ['yapf']

" allow for  formatting of range
" let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
" let g:formatters_python = ['autopep8']


autocmd FileType c,cpp,python nnoremap <buffer><Leader>= :<C-u>Autoformat<CR>
autocmd FileType c,cpp,python vnoremap <buffer>= :Autoformat<CR>

