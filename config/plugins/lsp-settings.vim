" vim-lsp settings :)
" ---

let g:lsp_diagnostics_enabled = 0
let g:lsp_virtual_text_enabled = 0
let g:lsp_auto_enable = 1

" let g:lsp_auto_enable = argc() > 0
let g:lsp_ignorecase = 1
let g:lsp_signs_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_fold_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:lsp_peek_alignment = 'top'
" let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 400
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_highlights_delay = 400
let g:lsp_diagnostics_signs_error = {'text': '✖'}
let g:lsp_diagnostics_signs_warning = {'text': '⬪'}
let g:lsp_diagnostics_signs_hint = {'text': '▪'}
let g:lsp_diagnostics_signs_information = {'text': '▫'}


" Apply settings for languages that registered LSP
function! s:on_lsp_buffer_enabled() abort

	if empty(globpath(&rtp, 'autoload/lsp.vim'))
		finish
	endif

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

	nmap <silent><buffer> ,s     <Plug>(lsp-signature-help)
	nmap <silent><buffer> [d     <Plug>(lsp-previous-diagnostic)
	nmap <silent><buffer> ]d     <Plug>(lsp-next-diagnostic)
	nmap <buffer> <Leader>F      <plug>(lsp-document-format)
	vmap <buffer> <Leader>F      <plug>(lsp-document-range-format)

endfunction

augroup lsp_user_plugin
	autocmd!

	autocmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()

	" autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END
