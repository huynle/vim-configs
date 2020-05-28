"" deoplete for nvim
"" ---

let g:deoplete#enable_at_startup = 0
set completeopt-=preview
set completeopt+=noselect

" toggling complete option with Mu Completion on/off
fun! ToggleCompleteopt()
  call deoplete#toggle()
endf
nnoremap <leader>cc :call ToggleCompleteopt()<CR>

"" let g:deoplete#enable_profile = 1
"" call deoplete#enable_logging('DEBUG', 'deoplete.log')<CR>
"" call deoplete#custom#source('tern', 'debug_enabled', 1)<CR>

" General settings " {{{
" ---
call deoplete#custom#option({
\ 'auto_complete_delay': 0,
\ 'auto_refresh_delay': 100,
\ 'auto_complete_popup': 'auto',
\ 'smart_case': v:true,
\ 'deoplete#skip_chars': ['(', ')', '<', '>']
\ })

call deoplete#custom#source('_', 'min_pattern_length', 2)
"" }}}

" Ranking and Marks " {{{
" Default rank is 100, higher is better.
call deoplete#custom#source('omni',          'mark', '⌾')
call deoplete#custom#source('go',            'mark', '⌁')
call deoplete#custom#source('jedi',          'mark', '⌁')
call deoplete#custom#source('vim',           'mark', '⌁')
call deoplete#custom#source('tag',           'mark', '⌦')
call deoplete#custom#source('around',        'mark', '↻')
call deoplete#custom#source('buffer',        'mark', 'ℬ')
call deoplete#custom#source('tmux-complete', 'mark', '⊶')
call deoplete#custom#source('syntax',        'mark', '♯')
call deoplete#custom#source('member',        'mark', '.')

call deoplete#custom#source('go',            'rank', 650)
call deoplete#custom#source('vim',           'rank', 640)
call deoplete#custom#source('jedi',          'rank', 610)
call deoplete#custom#source('omni',          'rank', 600)
call deoplete#custom#source('member',        'rank', 500)
call deoplete#custom#source('file_include',  'rank', 420)
call deoplete#custom#source('file',          'rank', 410)
call deoplete#custom#source('tag',           'rank', 400)
call deoplete#custom#source('around',        'rank', 330)
call deoplete#custom#source('buffer',        'rank', 320)
call deoplete#custom#source('dictionary',    'rank', 310)
call deoplete#custom#source('tmux-complete', 'rank', 300)
call deoplete#custom#source('syntax',        'rank', 200)

" }}}
" Matchers and Converters " {{{
" ---

" Default sorters: ['sorter_rank']
" Default matchers: ['matcher_length', 'matcher_fuzzy']

call deoplete#custom#source('_', 'converters', [
	\ 'converter_remove_paren',
	\ 'converter_remove_overlap',
	\ 'converter_truncate_abbr',
	\ 'converter_truncate_menu',
	\ ])

call deoplete#custom#source('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
call deoplete#custom#source('_', 'sorters', ['sorter_rank'])

" }}}
" Key-mappings and Events " {{{
" ---

" autocmd MyAutoCmd CompleteDone * silent! pclose!

" Movement within 'ins-completion-menu'
imap <expr><C-j>   pumvisible() ? "\<Down>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<Up>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>" : "\<C-u>"

" Undo completion
inoremap <expr><C-g> deoplete#undo_completion()

" Redraw candidates
inoremap <expr><C-g> deoplete#refresh()
inoremap <expr><C-l> deoplete#complete_common_string()

"" <CR>: If popup menu visible, expand snippet or close popup with selection,
""       Otherwise, check if within empty pair and use delimitMate.
" inoremap <silent><expr><CR> pumvisible() ?
" 	\ (neosnippet#expandable() ? neosnippet#mappings#expand_impl() : deoplete#close_popup())
" 		\ : (delimitMate#WithinEmptyPair() ? "\<C-R>=delimitMate#ExpandReturn()\<CR>" : "\<CR>")

"" <Tab> completion:
"" 1. If popup menu is visible, select and insert next item
"" 2. Otherwise, if within a snippet, jump to next input
"" 3. Otherwise, if preceding chars are whitespace, insert tab char
"" 4. Otherwise, start manual autocomplete
" imap <silent><expr><Tab> pumvisible() ? "\<Down>"
" 	\ : (<SID>is_whitespace() ? "\<Tab>"
" 	\ : deoplete#complete()))
" imap <silent><expr><Tab> pumvisible() ? "\<Down>"
" 	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
" 	\ : (<SID>is_whitespace() ? "\<Tab>"
" 	\ : deoplete#manual_complete()))

" smap <silent><expr><Tab> pumvisible() ? "\<Down>"
" 	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
" 	\ : (<SID>is_whitespace() ? "\<Tab>"
" 	\ : deoplete#manual_complete()))
"
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

imap <expr><TAB>
		\ pumvisible()? "\<C-y>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
        let col = col('.') - 1
        return ! col || getline('.')[col - 1] =~? '\s'
endfunction

"" this is taken care of by 'noselect' option by completeopt
function s:smart_carriage_return()
	let g:info=complete_info()
   " if get(g:info, 'pum_visible', -1) == 0 || get(g:info, 'selected', -1) == 0
   if get(g:info, 'selected', -1) == 0
			echom "got here 1"
      return "\<CR>"
		elseif get(g:info, 'pum_visible', -1) == 1 && get(g:info, 'selected', -1) == 0
			echom "got here"
			return "\<CR>"
		else
      return "\<C-y>"
   endif
endfunction


function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}
" }}}

"" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
