"" for plugin specific configurations 


if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a/ :Tabularize /\/\/<CR>
  vmap <Leader>a/ :Tabularize /\/\/<CR>
endif

" EasyMotion
nmap ss <Plug>(easymotion-s2)
nmap sd <Plug>(easymotion-s)
nmap sf <Plug>(easymotion-overwin-f)
map  sh <Plug>(easymotion-linebackward)
map  sl <Plug>(easymotion-lineforward)
" map  sj <Plug>(easymotion-j)
" map  sk <Plug>(easymotion-k)
map  s/ <Plug>(easymotion-sn)
omap s/ <Plug>(easymotion-tn)
map  sn <Plug>(easymotion-next)
map  sp <Plug>(easymotion-prev)

""""""""""""" Localvimrc
let g:localvimrc_enable = 1
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_event = [ "BufRead", "BufWrite"]
let g:localvimrc_name = [ "$PROJECTCONFIG/config.vim", "$PROJECTCONFIG/local.vim" ]

""""""""""""" NERDTree
let g:NERDTreeMapOpenSplit = 'sg'
let g:NERDTreeMapOpenVSplit = 'sv'
let g:NERDTreeMapOpenInTab = 'st'
let g:NERDTreeMapOpenInTabSilent = 'sT'
let g:NERDTreeMapUpdirKeepOpen = '<BS>'
let g:NERDTreeMapOpenRecursively = 't'
let g:NERDTreeMapCloseChildren = 'T'
let g:NERDTreeMapToggleHidden = '.'

let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 25
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeAutoDeleteBuffer = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeBookmarksFile = $VARPATH.'/treemarks'
let NERDTreeIgnore = [
	\ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$',
	\ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.cache$'
	\ ]

nnoremap <silent> <LocalLeader>e :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <LocalLeader>a :<C-u>NERDTreeFind<CR>


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


""""""""""" TAGBAR stuff
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>t  :TagbarOpen j<CR>
let g:tagbar_sort = 0
let g:tagbar_autofocus = 0
let g:tagbar_width = 30
let g:tagbar_autoclose = 0
let g:tagbar_expand=1
let g:tagbar_compact = 1
let g:tagbar_indent = 1


""""""""""" screenrc specific for copying and pasting
if exists("$BUFFERFILE")
  vnoremap <silent><leader>y :w! ~/.buffer<CR>
  " nnoremap <leader>y :'<,'>w! /home/e367212/.buffer<CR>
  " vnoremap <leader>y y :call writefile([getreg('0', 1)], "/home/e367212/.buffer")<CR>
  " vnoremap <leader>y :w! /home/e367212/.buffer
  nnoremap <silent><leader>p :.-1read ~/.buffer<CR>
  " vnoremap <silent><leader>p :'<,'>d|call read ~/.buffer<CR>
  xnoremap <leader>p "_d :.-2read ~/.buffer<CR>
endif

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


"""""" Vimwiki 
let g:vimwiki_use_calendar = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_tags_header = 'Generated Tags'
let g:vimwiki_markdown_header_style = 0
let g:vimwiki_autowriteall = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_html_header_numbering = 1
let g:vimwiki_html_header_numbering_sym = '.'
let g:vimwiki_list = [
\   { 'diary_header': 'Daily',
\     'diary_caption_level': -1,
\     'links_space_char': '-',
\     'auto_diary_index': 1,
\     'auto_toc': 0,
\     'auto_tags': 1,
\     'auto_generate_tags': 1,
\     'auto_generate_links': 1,
\     'path': '~/docs/wiki/',
\     'exclude_files': ['**/README.md'],
\     'syntax': 'markdown',
\     'ext': '.md' },
\   { 'path': '~/docs/orion/',
\     'links_space_char': '_',
\     'syntax': 'markdown',
\     'ext': '.md' }
\ ]


" nnoremap <silent> <Leader>W :<C-u>VimwikiTabIndex<CR>
nnoremap <silent> <Leader>W :<C-u>VimwikiIndex<CR>


"""""" Quickhl
nmap <Leader>, <Plug>(quickhl-manual-this)
xmap <Leader>, <Plug>(quickhl-manual-this)


"""""" Junegun/vim-peekaboo
nnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  0)<cr>
xnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  1)<cr>
nnoremap <buffer> <silent> @ :<c-u>call peekaboo#peek(v:count1, 'replay', 0)<cr>
inoremap <buffer> <silent> <c-r> <c-o>:call peekaboo#peek(1, 'ctrl-r',  0)<cr>

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'data'
" let g:mdip_imgname = 'image'
