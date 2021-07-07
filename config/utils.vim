" Commands
"---------------------------------------------------------

" augroup MyAutoCmd
"   " clear group first, then everything else can be loaded
"   autocmd!
  
"   " you can also write it like the other autocmd below
"   autocmd BufRead,BufNewFile *.dr set filetype=python

"   """"" TAGs: Covered by gutentags
"   " autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.vim call UpdateTags()
"   " autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateCscope()
 

" augroup END


command! ZoomToggle call s:ZoomToggle()

" Diff command credits: https://github.com/Shougo/shougo-s-github
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" Functions
"---------------------------------------------------------

" Makes * and # work on visual mode too.
" See: http://github.com/nelstrom/vim-visual-star-search
function! VSetSearch(cmdtype) "{{{
  let temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
  let @s = temp
endfunction "}}}

function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" aPPEND MODELINE AFTER LAST LINE IN BUFFer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! AppendModeline() "{{{
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction "}}}

" Zoom / Restore window
function! s:ZoomToggle() "{{{
  if exists('t:zoomed') && t:zoomed > -1
    execute t:zoom_winrestcmd
    let t:zoomed = -1
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = bufnr('%')
  endif
endfunction "}}}

"" Source a range
" function! SourceRange() range
"   let tmpsofile = tempname()
"   call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
"   execute "source " . l:tmpsofile
"   call delete(l:tmpsofile)
" endfunction
" command! -range Source <line1>,<line2>call SourceRange()
" then use `:'<,'>Source` to source the selection

" source the current file
nmap <leader>so :source %<CR>
" source a visual range
vmap <leader>so y:@"<CR>


""""""""""" screenrc specific for copying and pasting
" if exists("$BUFFERFILE")
"   vnoremap <silent><leader>y :w! ~/.buffer<CR>
"   " nnoremap <leader>y :'<,'>w! /home/e367212/.buffer<CR>
"   " vnoremap <leader>y y :call writefile([getreg('0', 1)], "/home/e367212/.buffer")<CR>
"   " vnoremap <leader>y :w! /home/e367212/.buffer
"   nnoremap <silent><leader>p :.-1read ~/.buffer<CR>
"   " vnoremap <silent><leader>p :'<,'>d|call read ~/.buffer<CR>
"   xnoremap <leader>p "_d :.-2read ~/.buffer<CR>
" endif

" a hacky way to get copy and paste through a shared file
" Copy - paste using file
" vmap <leader>y :w! ~/.vbuf<CR>
vmap <leader>y ""y :call writefile(getreg('"',1,1), expand('$HOME/.vbuf'))<CR>
nmap <leader>y :.w! ~/.vbuf<CR>
nmap <leader>p :r ~/.vbuf<CR>

" Yank buffer's relative/absolute path to clipboard
" nnoremap <Leader>y :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
" nnoremap <Leader>Y :call writefile([expand("%:p")], expand('$HOME/.vbuf'))<CR>:echo 'Yanked absolute path'<CR>
nnoremap <Leader>Y :call writefile([expand("%:p:h")], expand('$HOME/.vbuf'))<CR>:echo 'Yanked absolute path'<CR>


"" change directory, helpful for vimwiki to switch directory for grepping
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


"" jump to to the next vim merge conflict
nnoremap <leader>gm /\v^\<\<\<\<\<\<\< \|\=\=\=\=\=\=\=$\|\>\>\>\>\>\>\> /<cr>
"}}}
