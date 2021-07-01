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
  \     [ 'gitbranch', 'diagnostic', 'readonly', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'fileformat', 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'gitbranch', 'diagnostic', 'readonly', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'fileformat', 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \   'git_status': 'LightlineGitStatus',
  \   'gitbranch': 'FugitiveHead',
  \   'git_file_status': 'LightlineGitFileStatus',
  \   'method': 'LightlineNearestMethodOrFunction',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \ },
  \ 'component': {
  \   'filename': '%<%{LightLineFilename()}',
  \ }
\ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitStatus() abort
  let status = get(g:, 'coc_git_status', '')
  return winwidth(0) > 10 ? status : ''
endfunction

function! LightlineGitFileStatus() abort
  let status = get(b:, 'coc_git_status', '')
  return winwidth(0) > 20 ? status : ''
endfunction


function! LightlineFugitive() abort
  if &filetype ==# 'help'
    return ''
  endif
  if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif
  try
    if exists('*fugitive#head')
      let head = fugitive#head()
    else
      return ''
    endif
    let b:lightline_fugitive = head
    let b:lightline_fugitive_ = reltime()
    return b:lightline_fugitive
  catch
  endtry
  return ''
endfunction

function! LightlineNearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" function! LightlineFilename()
"   " let root = fnamemodify(get(b:, 'git_dir'), ':h')
"   let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
"   let path = expand('%:p')
"   if path[:len(root)-1] ==# root
"     return path[len(root)+1:]
"   endif
"   return expand('%')
" endfunction

function! LightLineFilename()
  let l:fname = expand('%:t')
  let l:fpath = expand('%')
  return &filetype ==# 'dirvish' ?
        \   (l:fpath ==# getcwd() . '/' ? fnamemodify(l:fpath, ':~') :
        \   fnamemodify(l:fpath, ':~:.')) :
        \ &filetype ==# 'fzf' ? 'fzf' :
        \ '' !=# l:fname ? fnamemodify(l:fpath, ':~:.') : '[No Name]'
endfunction


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
