"" for plugin specific configurations 
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a/ :Tabularize /\/\/<CR>
  vmap <Leader>a/ :Tabularize /\/\/<CR>
endif




"""""""""""" Easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"""""""""""" Commentary
xmap <Leader>v  <Plug>Commentary
nmap <Leader>v  <Plug>CommentaryLine
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary


"""""""""""" accelerated motion
nmap <silent> j <Plug>(accelerated_jk_gj)
nmap <silent> k <Plug>(accelerated_jk_gk)

""""" CODE COMPLETION AND ANLYSIS with ASYNC STUFF
let g:asyncomplete_auto_completeopt = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_virtual_text_enabled = 0


"""""" ultisnips
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsListSnippets = ''
let g:UltiSnipsJumpForwardTrigger = '<C-f>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'


"""""" Quickhl
nmap ** <Plug>(quickhl-manual-this)
xmap ** <Plug>(quickhl-manual-this)

"""""" Junegun/vim-peekaboo
nnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  0)<cr>
xnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  1)<cr>
nnoremap <buffer> <silent> @ :<c-u>call peekaboo#peek(v:count1, 'replay', 0)<cr>
inoremap <buffer> <silent> <c-r> <c-o>:call peekaboo#peek(1, 'ctrl-r',  0)<cr>


