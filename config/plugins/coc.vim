" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:coc_global_extensions = [
    \ 'coc-actions',
    \ 'coc-highlight',
    \ 'coc-lists',
    \ 'coc-pairs',
    \ 'coc-git',
    \ 'coc-floaterm',
    \ 'coc-yaml',
    \ 'coc-pyright',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-explorer',
    \ 'coc-svg',
    \ 'coc-prettier',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-json',
    \ 'coc-marketplace',
    \ 'coc-pydocstring',
    \ 'coc-sh',
    \ 'coc-spell-checker',
    \ 'coc-docker'
    \ ]

" " Use tab for trigger completion with characters ahead and navigate.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

""----------------------- Coc Key Remapping --------------------------
"" Use <c-space> to enter selected.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

""Use <C-j> and <C-k> to navigate the completion list:
"inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" navigate pop up with <C-j> and <C-k>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" -------

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif



" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" " nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
" nmap <silent> <C-]>  <Plug>(coc-definition)

function! s:goto_tag(tagkind) abort
  let tagname = expand('<cWORD>')
  let winnr = winnr()
  let pos = getcurpos()
  let pos[0] = bufnr()

  if CocAction('jump' . a:tagkind)
    call settagstack(winnr, { 
      \ 'curidx': gettagstack()['curidx'], 
      \ 'items': [{'tagname': tagname, 'from': pos}] 
      \ }, 't')
  endif
endfunction
nmap <silent> <c-]> :call <SID>goto_tag("Definition")<CR>
nmap <silent> gi :call <SID>goto_tag("Implementation")<CR>
nmap <silent> gr :call <SID>goto_tag("References")<CR>

" nmap <silent> <C-]>  <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <silent><leader>a  <Plug>(coc-codeaction-selected)<cr>
nmap <silent><leader>a  <Plug>(coc-codeaction-selected)<cr>
vmap <silent><leader>a  <Plug>(coc-codeaction-selected)<cr>

" Remap keys for applying codeAction to the current line.
nmap <silent><leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')






"====== git stuff
" navigate chunks of current buffer
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)


" Explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\     'quit-on-open': v:true
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\     'quit-on-open': v:true
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\     'quit-on-open': v:true
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\     'quit-on-open': v:true
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]',
\     'quit-on-open': v:true
\   }
\ }

nmap <silent><localleader>e :CocCommand explorer --position left --quit-on-open<CR>
" nmap <localleader>ee :CocCommand explorer --preset floating<CR>
" autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

function! s:enter_explorer()
  if &filetype == 'coc-explorer'
    " statusline
    setl statusline=
  endif
endfunction

augroup CocExplorerCustom
  autocmd!
  autocmd BufEnter * call <SID>enter_explorer()
augroup END




" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)


" " List all presets
" nnoremap <leader>el :CocFzfList explPresets
" " " Mappings using CoCList:
" nnoremap <silent> <leader>e  :<C-u>CocFzfList diagnostics --current-buf<cr>
" nnoremap <silent> <leader>o  :<C-u>CocFzfList outline<cr>
" nnoremap <silent> <leader>w  :exe 'CocFzfList --interactive --normal --input='.expand('<cword>').' words'<CR>
" nnoremap <silent> <leader>g  :<C-u>CocFzfList lines<CR>
" nnoremap <silent><LocalLeader>c :<C-u>CocFzfList commands<cr>
" nnoremap <silent><LocalLeader>f :<C-u>CocFzfList files<CR>
" nnoremap <silent><LocalLeader>b :<C-u>CocFzfList buffers<CR>
" nnoremap <silent><LocalLeader>m :<C-u>CocFzfList marks<CR>
" nnoremap <silent><LocalLeader>v :<C-u>CocFzfList registers<CR>
" nnoremap <silent><LocalLeader>s  :<C-u>CocFzfList symbols<cr>
" " nnoremap <silent><LocalLeader>g  :<C-u>CocFzfList --normal gstatus<CR>
" nnoremap <silent><LocalLeader>g  :<C-u>CocFzfList  grep<CR>
" nnoremap <silent><LocalLeader>p  :<C-u>CocFzfListResume<CR>
" let g:coc_fzf_preview = ''
" let g:coc_fzf_opts = []



" " Mappings using CoCList:
nnoremap <silent> <leader>e  :<C-u>CocList diagnostics --current-buf<cr>
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>w  :exe 'CocList --interactive --normal --input='.expand('<cword>').' words'<CR>
nnoremap <silent> <leader>g  :<C-u>CocList lines<CR>
nnoremap <silent><LocalLeader>c :<C-u>CocList commands<cr>
nnoremap <silent><LocalLeader>f :<C-u>CocList files<CR>
nnoremap <silent><LocalLeader>, :<C-u>CocList mru<CR>
nnoremap <silent><LocalLeader>b :<C-u>CocList buffers<CR>
nnoremap <silent><LocalLeader>m :<C-u>CocList maps<CR>
nnoremap <silent><LocalLeader>v :<C-u>CocList registers<CR>
nnoremap <silent><LocalLeader>s  :<C-u>CocList symbols<cr>
nnoremap <silent><LocalLeader>h  :<C-u>CocList helptags<cr>
" nnoremap <silent><LocalLeader>g  :<C-u>CocList --normal gstatus<CR>
nnoremap <silent><LocalLeader>g  :<C-u>CocList grep<CR>
nnoremap <silent><leader><leader>  :<C-u>CocListResume<CR>

