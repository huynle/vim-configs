" :h denite.txt
" ---
" Problems? https://github.com/Shougo/denite.nvim/issues

" Don't reload Denite twice (on vimrc reload)
if exists('*denite#start')
	finish
endif




" Denite general settings
call denite#custom#option('_', {
	\ 'prompt': '❯',
	\ 'auto_resume': 1,
	\ 'start_filter': 1,
	\ 'statusline': 1,
	\ 'smartcase': 1,
	\ 'vertical_preview': 1,
	\ 'max_dynamic_update_candidates': 50000,
	\ })

" Interactive grep search
call denite#custom#var('grep', 'min_interactive_pattern', 2)
call denite#custom#source('grep', 'args', ['', '', '!'])

" Use Neovim's floating window
if has('nvim')
	call denite#custom#option('_', {
		\ 'statusline': 0,
		\ 'split': 'horizontal',
		\ 'floating_preview': 1,
		\ 'filter_split_direction': 'floating',
		\ })
endif

" Allow customizable window positions: top, bottom, center (default)
function! s:denite_resize(position)
	if a:position ==# 'top'
		call denite#custom#option('_', {
			\ 'winwidth': (&columns - (&columns / 3)) - 1,
			\ 'winheight': &lines / 3,
			\ 'wincol': 0,
			\ 'winrow': 1,
			\ })
	elseif a:position ==# 'bottom'
		call denite#custom#option('_', {
			\ 'winwidth': (&columns - (&columns / 3)) - 1,
			\ 'winheight': &lines / 3,
			\ 'wincol': 0,
			\ 'winrow': (&lines - 2) - (&lines / 3),
			\ })
	else
		" Use Denite default, which is centered.
	endif
endfunction

" Set Denite's window position
let g:denite_position = get(g:, 'denite_position', '')
call s:denite_resize(g:denite_position)

" MATCHERS
" Default is 'matcher/fuzzy'
call denite#custom#source('tag', 'matchers', ['matcher/substring'])

" SORTERS
" Default is 'sorter/rank'
call denite#custom#source('z', 'sorters', ['sorter_z'])

" CONVERTERS
" Default is none
call denite#custom#source(
	\ 'buffer,file_mru,file_old',
	\ 'converters', ['converter_relative_word'])

" FIND and GREP COMMANDS
" ---
" The Silver Searcher (ag)
if executable('ag')
	call denite#custom#var('file/rec', 'command',
		\ ['ag', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])

	" Setup ignore patterns in your .agignore file! Skipping VCS ignores.
	" https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
	call denite#custom#var('grep', {
		\ 'command': ['ag'],
		\ 'default_opts': ['--vimgrep', '-i', '--hidden'],
		\ 'recursive_opts': [],
		\ 'pattern_opt': [],
		\ 'final_opts': [],
		\ 'separator': ['--'],
		\ })

" Ripgrep
elseif executable('rg')
	call denite#custom#var('file/rec', 'command',
		\ ['rg', '--files', '--glob', '!.git'])

	call denite#custom#var('grep', {
		\ 'command': ['rg'],
		\ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
		\ 'recursive_opts': [],
		\ 'pattern_opt': ['--regexp'],
		\ 'final_opts': [],
		\ 'separator': ['--'],
		\ })

" Ack command
elseif executable('ack')
	call denite#custom#var('grep', {
		\ 'command': ['ack'],
		\ 'default_opts': [
		\   '--ackrc', $HOME.'/.config/ackrc', '-H', '-i',
		\   '--nopager', '--nocolor', '--nogroup', '--column',
		\ ],
		\ 'recursive_opts': [],
		\ 'pattern_opt': ['--match'],
		\ 'separator': ['--'],
		\ 'final_opts': [],
		\ })
endif

" Denite EVENTS
augroup user_plugin_denite
	autocmd!

	autocmd FileType denite call s:denite_settings()
	autocmd FileType denite-filter call s:denite_filter_settings()
	autocmd User denite-preview call s:denite_preview()

	autocmd VimResized * call s:denite_resize(g:denite_position)

	" Enable Denite special cursor-line highlight
	autocmd WinEnter * if &filetype =~# '^denite'
		\ |   highlight! link CursorLine WildMenu
		\ | endif

	" Disable Denite special cursor-line highlight
	autocmd WinLeave * if &filetype ==# 'denite'
		\ |   highlight! link CursorLine NONE
		\ | endif
augroup END

" Denite main window settings
function! s:denite_settings() abort
	" Window options
	setlocal signcolumn=no cursorline

	" Denite selection window key mappings
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> /    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> dd   denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> st   denite#do_map('do_action', 'tabopen')
	nnoremap <silent><buffer><expr> sv   denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> sg   denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> '    denite#do_map('quick_move')
	nnoremap <silent><buffer><expr> q    denite#do_map('quit')
	nnoremap <silent><buffer><expr> r    denite#do_map('redraw')
	nnoremap <silent><buffer><expr> yy   denite#do_map('do_action', 'yank')
	nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
	nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
	nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
endfunction

" Denite-preview window settings
function! s:denite_preview() abort
	" Window options
	setlocal nocursorline colorcolumn= signcolumn=no nonumber nolist nospell

	if &lines > 35
		resize +8
	endif
	" let l:pos = win_screenpos(win_getid())
	" let l:heighten = &lines - l:pos[0]
	" execute 'resize ' . l:heighten

	" Clear indents
	if exists('*indent_guides#clear_matches')
		call indent_guides#clear_matches()
	endif
endfunction

" Denite-filter window settings
function! s:denite_filter_settings() abort
	" Window options
	setlocal signcolumn=yes nocursorline nonumber norelativenumber

	" Disable Deoplete auto-completion within Denite filter window
	if exists('*deoplete#custom#buffer_option')
		call deoplete#custom#buffer_option('auto_complete', v:false)
	endif

	" Denite Filter window key mappings
	imap <silent><buffer> jj          <Plug>(denite_filter_quit)
	nmap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
	imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
	nmap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
	imap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
	inoremap <silent><buffer> <Tab>
		\ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	inoremap <silent><buffer> <S-Tab>
		\ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction



"" KEY MAPPING
nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh -no-start-filter<CR>
nnoremap <silent><LocalLeader>f :<C-u>Denite file/rec<CR>
nnoremap <silent><LocalLeader>g :<C-u>Denite grep -start-filter<CR>
nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file_mru -default-action=switch<CR>
nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec directory_mru -default-action=cd<CR>
nnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register<CR>
xnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register -default-action=replace<CR>
nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list -no-start-filter<CR>
nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list -no-start-filter<CR>
nnoremap <silent><LocalLeader>n :<C-u>Denite dein<CR>
nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file/point -no-start-filter<CR>
nnoremap <silent><LocalLeader>u :<C-u>Denite junkfile:new junkfile -buffer-name=list<CR>
nnoremap <silent><LocalLeader>o :<C-u>Denite outline -no-start-filter<CR>
nnoremap <silent><LocalLeader>s :<C-u>Denite session -buffer-name=list<CR>
nnoremap <silent><LocalLeader>t :<C-u>Denite tag<CR>
nnoremap <silent><LocalLeader>p :<C-u>Denite jump<CR>
nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
nnoremap <silent><LocalLeader>m :<C-u>Denite file/rec -buffer-name=memo -path=~/docs/books<CR>
nnoremap <silent><LocalLeader>z :<C-u>Denite z -buffer-name=list<CR>
nnoremap <silent><LocalLeader>; :<C-u>Denite command_history command<CR>
nnoremap <silent><expr><LocalLeader>/ wordcount().chars > 10000 ?
				\ ":\<C-u>Denite -search line/external\<CR>"
				\ : ":\<C-u>Denite -search line\<CR>"
nnoremap <silent><expr><LocalLeader>* wordcount().chars > 10000 ?
				\ ":\<C-u>DeniteCursorWord -no-start-filter -search line/external\<CR>"
				\ : ":\<C-u>DeniteCursorWord -no-start-filter -search line\<CR>"

" chemzqm/denite-git
nnoremap <silent> <Leader>gl :<C-u>Denite gitlog:all -no-start-filter<CR>
nnoremap <silent> <Leader>gs :<C-u>Denite gitstatus -no-start-filter<CR>
nnoremap <silent> <Leader>gc :<C-u>Denite gitbranch -no-start-filter<CR>

" Open Denite with word under cursor or selection
nnoremap <silent> <Leader>gt :DeniteCursorWord tag:include -no-start-filter -immediately<CR>
nnoremap <silent> <Leader>gf :DeniteCursorWord file/rec -no-start-filter<CR>
nnoremap <silent> <Leader>gg :DeniteCursorWord grep -no-start-filter<CR>
vnoremap <silent> <Leader>gg
				\ :<C-u>call <SID>get_selection('/')<CR>
				\ :execute 'Denite -no-start-filter grep:::'.@/<CR><CR>

function! s:get_selection(cmdtype)
				let temp = @s
				normal! gv"sy
				let @/ = substitute(escape(@s, '\' . a:cmdtype), '\n', '\\n', 'g')
				let @s = temp
endfunction



" vim: set ts=2 sw=2 tw=80 noet :
