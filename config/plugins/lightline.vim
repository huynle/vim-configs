" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"

" set statusline =%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}
" set statusline+=[%n]%<%f\ %h%m%r\ %=\
" set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
" set statusline+=%-14.(%l,%c%V%)\ %P


set noshowmode
" lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'git_status', 'diagnostic', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'fileformat', 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \   'git_status': 'LightlineGitStatus',
  \   'git_file_status': 'LightlineGitFileStatus',
  \   'method': 'LightlineNearestMethodOrFunction',
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \ }
\ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitStatus() abort
  let status = get(g:, 'coc_git_status', '')
  return winwidth(0) > 80 ? status : ''
endfunction

function! LightlineGitFileStatus() abort
  let status = get(b:, 'coc_git_status', '')
  return winwidth(0) > 20 ? status : ''
endfunction

function! LightlineNearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" function! LightlineFugitive()
"   try
"     if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
"       let mark = ''  " edit here for cool mark
"       let branch = FugitiveHead()
"       return branch !=# '' ? mark.branch : ''
"     endif
"   catch
"   endtry
"   return ''
" endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction


autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
autocmd User CocGitStatusChange call lightline#update()
