" File Types {{{
"-------------------------------------------------

augroup MyAutoCmd
  " clear group first, then everything else can be loaded
  autocmd!
  
  " you can also write it like the other autocmd below
  autocmd BufRead,BufNewFile *.dr set filetype=python

  """"" TAGs: Covered by gutentags
  " autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.vim call UpdateTags()
  " autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateCscope()
	
  " Check if file changed when its window is focus, more eager than 'autoread'
  autocmd FocusGained * :silent! !

  autocmd FileType python
    \ setlocal foldmethod=indent expandtab smarttab nosmartindent
    \ | setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd FocusGained * checktime

	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

  " Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	autocmd FileType python
		\ setlocal expandtab smarttab nosmartindent
		\ | setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80


	autocmd FileType markdown
		\ setlocal expandtab spell conceallevel=0
		\ | setlocal autoindent formatoptions=tcroqn2 comments=n:>

	" Disable paste after leaving insert mode
	autocmd InsertLeave *
			\ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
			\ if &l:diff | diffupdate | endif

	" Open Quickfix window automatically
	autocmd QuickFixCmdPost [^l]* leftabove copen
		\ | wincmd p | redraw!
	autocmd QuickFixCmdPost l* leftabove lopen
		\ | wincmd p | redraw!

	" Fix window position of help/quickfix
	autocmd FileType help if &l:buftype ==# 'help'
		\ | wincmd K | endif
	autocmd FileType qf   if &l:buftype ==# 'quickfix'
		\ | wincmd J | endif

	" Update diff
	autocmd InsertLeave * if &l:diff | diffupdate | endif

	" Open quickfix in split
	autocmd FileType qf nnoremap <buffer> sv :call <SID>OpenQuickfix("vsplit")<CR>
	autocmd FileType qf nnoremap <buffer> sg :call <SID>OpenQuickfix("split")<CR>

	" open vimwiki in split
	" autocmd FileType vimwiki nnoremap sg <Plug>VimwikiSplitLink<CR>

  " autocmd FileType vimwiki nnoremap <silent><buffer> <CR> <Plug>VimwikiSplitLink<CR>


augroup END

" }}}

" vim: set ts=2 sw=2 tw=80 noet :
