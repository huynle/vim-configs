" command! LspHover lua vim.lsp.buf.hover()<CR>
" command! LspDisable lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

" LSP config, in lua, load lsp in lua/lsp/init.lua
lua require("lsp")

" Show errors after 1 second
set updatetime=1000

set completeopt=menuone,noinsert,noselect
set shortmess+=c

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end

" Code snippets
let g:completion_enable_snippet = 'UltiSnips'


inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


inoremap <expr> <C-j>   pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<Up>"   : "\<C-k>"
inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>" : "\<C-d>"
inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>"   : "\<C-u>"


function s:smart_carriage_return()
	if pumvisible()
		let l:info = complete_info()

		" Detect non-selection and insert new-line
		if get(l:info, 'selected', -1) == -1
			" return "\<C-y>\<CR>"
			return "\<Down>\<CR>"
		endif
		" Detect snippet and expand (via UltiSnips)
		if exists('g:UltiSnipsEditSplit')
			let l:menu = get(get(l:info['items'], l:info['selected'], {}), 'menu')
			if len(l:menu) > 0 && stridx(l:menu, 'Snips: ') == 0
				return "\<C-y>\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
			endif
		endif
		" Otherwise, when pum is visible, insert selected completion
		return "\<C-y>"
	endif

	" Expand empty pairs (via delimitMate)
	if get(b:, 'delimitMate_enabled') && delimitMate#WithinEmptyPair()
		return "\<C-R>=delimitMate#ExpandReturn()\<CR>"
	endif

	" Propagate a carriage-return
	return "\<CR>"
endfunction


" completion_confirm_key has to be cleared for this next to work
let g:completion_confirm_key = ""
" inoremap <expr> <CR>    pumvisible() ? "\<Down>\<CR>" : "\<CR>"
inoremap <silent> <CR> <C-R>=<SID>smart_carriage_return()<CR>
nnoremap <buffer> <M-CR> :lua vim.lsp.buf.code_action()<CR>

