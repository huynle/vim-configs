" vim-lsp-settings settings :)
" ---
let g:lsp_diagnostics_enabled = 0
let g:lsp_virtual_text_enabled = 0
let g:lsp_auto_enable = 1


" Apply settings for languages that registered LSP
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	setlocal foldmethod=expr
		\ foldexpr=lsp#ui#vim#folding#foldexpr()
		\ foldtext=lsp#ui#vim#folding#foldtext()

	" Prefer native help with vim files
	if &filetype != 'vim'
		nmap <silent><buffer> K  <Plug>(lsp-hover)
	endif

	nmap <silent><buffer> <C-]>  <Plug>(lsp-definition)
	nmap <silent><buffer> g<C-]> <Plug>(lsp-peek-definition)
	nmap <silent><buffer> gd     <Plug>(lsp-peek-declaration)
	nmap <silent><buffer> gi     <Plug>(lsp-peek-implementation)
	nmap <silent><buffer> gy     <Plug>(lsp-peek-type-definition)
	nmap <silent><buffer> gY     <Plug>(lsp-type-hierarchy)
	nmap <silent><buffer> ,s     <Plug>(lsp-signature-help)
	nmap <silent><buffer> gr     <Plug>(lsp-references)
	nmap         <buffer> <leader>r   <Plug>(lsp-rename)
endfunction

augroup lsp_user_plugin
	autocmd!

	autocmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()

	" autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END
