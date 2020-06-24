" # READ MORE here - https://github.com/junegunn/fzf.vim
"
" :Files [PATH]	Files (runs $FZF_DEFAULT_COMMAND if defined)
" :GFiles [OPTS]	Git files (git ls-files)
" :GFiles?	Git files (git status)
" :Buffers	Open buffers
" :Colors	Color schemes
" :Ag [PATTERN]	ag search result (ALT-A to select all, ALT-D to deselect all)
" :Rg [PATTERN]	rg search result (ALT-A to select all, ALT-D to deselect all)
" :Lines [QUERY]	Lines in loaded buffers
" :BLines [QUERY]	Lines in the current buffer
" :Tags [QUERY]	Tags in the project (ctags -R)
" :BTags [QUERY]	Tags in the current buffer
" :Marks	Marks
" :Windows	Windows
" :Locate PATTERN	locate command output
" :History	v:oldfiles and open buffers
" :History:	Command history
" :History/	Search history
" :Snippets	Snippets (UltiSnips)
" :Commits	Git commits (requires fugitive.vim)
" :BCommits	Git commits for the current buffer
" :Commands	Commands
" :Maps	Normal mode mappings
" :Helptags	Help tags 1
" :Filetypes	File types

"" KEY MAPPING
nnoremap <silent><leader><leader> :<C-u>Files<CR>
nnoremap <silent><leader>g :<C-u>Rg<CR>
nnoremap <silent><leader>, :<C-u>Buffer<CR>
nnoremap <silent><leader>s :<C-u>Snippets<CR>
" nnoremap <silent><leader>t :<C-u>Tags<CR>
nnoremap <silent><leader>l :<C-u>Lines<CR>
nnoremap <silent><leader>hh :<C-u>Helptags<CR>
nnoremap <silent><leader>hc :<C-u>Commands<CR>
nnoremap <silent><leader>hm :<C-u>Maps<CR>
" nnoremap <silent><leader>w :<C-u>Windows<CR>

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-g': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

" map <C-f> :Files<CR>
" map <leader>b :Buffers<CR>
" nnoremap <leader>g :Rg<CR>
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
