" let base16colorspace=256  " Access colors present in 256 colorspace
" Theme
" -----

" Enable 256 color terminal
set t_Co=256

" Enable true color
if has('termguicolors')
	set termguicolors
endif

""Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

" gVim Appearance {{{
" ---------------------------------------------------------
if has('gui_running')

	set guifont=Dejavu\ Sans\ Mono\ for\ Powerline:h10
	
	set lines=60 columns=108 linespace=0
	
	set guioptions-=m  "remove menu bar
	set guioptions-=T  " no toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guioptions+=c  " show console dialogs

	" Silent bell
	autocmd GUIEnter * set vb t_vb=
	
endif
" }}}

function! s:theme_write()
        call writefile([g:colors_name, &background], s:cache)
endfunction


" COLORSCHEME NAME
let s:cache = $VARPATH.'/theme.txt'
let g:default_theme = 'one'
let g:default_bg = 'dark'

function! s:setColors()
        " if ! exists('g:colors_name')
        execute 'colorscheme' filereadable(s:cache) ? readfile(s:cache)[0] : g:default_theme
        execute 'set background='.(filereadable(s:cache) ? readfile(s:cache)[1] : g:default_bg)
        call s:theme_write()
        " endif
endfunction

" function! s:reloadBackground()
        " let l:saved_bg = filereadable(s:cache) ? readfile(s:cache)[1] : 'dark'
        " if l:saved_bg != &background
                " call s:setColors()
        " endif
" endfunction


function! ToggleBg()
    if &background ==? 'dark'
        set background=light
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/huy-light.sh'))
              call s:theme_write()
    else
        set background=dark
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/huy-dark.sh'))
              call s:theme_write()
    endif
		call ToggleTransparent()
                " call s:theme_write()
    " silent !osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
endfunction

function! ToggleTransparent()
		hi! Normal ctermbg=NONE guibg=NONE
		hi! NonText ctermbg=NONE guibg=NONE
endfunction

command! ToggleBackground call ToggleBg()
" command! ReloadBackground call s:reloadBackground()

" ReloadBackground
nnoremap <silent><Leader>bg :<C-u>call ToggleBg()<CR>

" THEME NAME
if filereadable(s:cache)
                " call s:reloadBackground()
                call s:setColors()
endif

" autocmd MyAutoCmd ColorScheme * call s:reloadBackground()
call ToggleTransparent()

" vim: set ts=2 sw=2 tw=80 noet :


