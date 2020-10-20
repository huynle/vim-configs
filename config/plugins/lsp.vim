let g:LanguageClient_rootMarkers = ['.project']
" let g:LanguageClient_settingsPath = ".vscode/settings.json"
let g:LanguageClient_changeThrottle = 0.1
let g:LanguageClient_diagnosticsList = "Disabled"
let g:LanguageClient_selectionUI = "Quickfix"
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
  \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
  \ 'python': [expand('$HOME/.cache/vim/venv/neovim3/bin/pyls')],
  \ 'cpp': ['/home/hle/.local/opt/cquery/build/release/bin/cquery',
  \ '--log-file=/tmp/cq.log',
  \ '--init={"cacheDirectory":"/home/hle/.cache/vim/cquery/"}'],
  \ 'c': ['/home/hle/.local/opt/cquery/build/release/bin/cquery',
  \ '--log-file=/tmp/cq.log',
  \ '--init={"cacheDirectory":"/home/hle/.cache/vim/cquery/"}']
  \ }


nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <F5> :Denite contextMenu<CR>
nnoremap <silent> <leader>r :<C-u>call LanguageClient#textDocument_rename()<CR>


nnoremap <silent> K :<C-u>call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gr :<C-u>call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> gd :<C-u>call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gi :<C-u>call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <M-]> :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <M-.> :call LanguageClient_textDocument_references()<cr>:Denite references<CR>
" nnoremap <silent> <M-.> :Denite references<CR>

nnoremap <leader>ji :Denite documentSymbol<cr>
nnoremap <leader>jI :Denite workspaceSymbol<cr>
nnoremap ,la :call LanguageClient_workspace_symbol({'query':input('workspace/symbol ')})<cr>

" augroup LanguageClient_config
"   au!
"   au BufEnter * let b:Plugin_LanguageClient_started = 0
"   au User LanguageClientStarted setl signcolumn=yes
"   au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
"   au User LanguageClientStopped setl signcolumn=auto
"   au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
"   au CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
" augroup END

" <C-u>:Denite location_list<CR>

	" nmap ma :<C-u>cgetexpr bm#location_list()<CR>
	"	\ :<C-u>Denite quickfix -buffer-name=list<CR>
