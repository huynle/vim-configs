" Vim Initialization
" " ------------------
set nocompatible
filetype off

" Respect XDG
if isdirectory($XDG_CONFIG_HOME.'/vim')
	let $VIMPATH=expand('$XDG_CONFIG_HOME/vim')
	let $VARPATH=expand('$XDG_CACHE_HOME/vim')
else
	let $VIMPATH=expand('$HOME/.config/nvim')
	let $VARPATH=expand('$HOME/.cache/vim')
endif

function! s:source_file(path)
	execute 'source' fnameescape($VIMPATH.'/config/'.a:path)
endfunction

" let g:python_host_prog = expand('$VARPATH/venv/neovim/bin/python')
" let g:python3_host_prog = expand('$VARPATH/venv/neovim/bin/python3')

" Python interpreter settings
function! s:main()
	if has('vim_starting')
		if has('nvim')
			" Try using pyenv virtualenv called 'neovim'
			let l:virtualenv = ''

			if ! empty($PYENV_ROOT)
				let l:virtualenv = expand('$PYENV_ROOT/versions/neovim/bin/python')
			endif

			if empty(l:virtualenv) || ! filereadable(l:virtualenv)
				" Fallback to old virtualenv location
				let l:virtualenv = expand('$VARPATH/venv/neovim/bin/python')
			endif

			if filereadable(l:virtualenv)
				let g:python3_host_prog = l:virtualenv
			endif

		elseif has('pythonx')
			if has('python3')
				set pyxversion=3
			elseif has('python')
				set pyxversion=2
			endif
		endif
	endif
endfunction

call s:main()

" Vim Directories {{{
" ---------------
if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$VARPATH/undo'), 'p')
	call mkdir(expand('$VARPATH/backup'))
endif

" Ensure custom spelling directory
if ! isdirectory(expand('$VIMPATH/spell'))
	call mkdir(expand('$VIMPATH/spell'))
endif
set undofile swapfile nobackup
set directory=$VARPATH/swap//,$VARPATH,~/tmp,/var/tmp,/tmp
set undodir=$VARPATH/undo//,$VARPATH,~/tmp,/var/tmp,/tmp
set backupdir=$VARPATH/backup/,$VARPATH,~/tmp,/var/tmp,/tmp
set viewdir=$VARPATH/view/
set nospell spellfile=$VIMPATH/spell/en.utf-8.add

""""
let $PROJECT=getcwd()
let $ROOT_MARKER ='.project'
let $PROJECTCONFIG=$PROJECT.'/'.$ROOT_MARKER

""" PLUGINS START """"

" ############ PLUG
let $PLUG=expand('$VIMPATH/plugged')
call plug#begin($PLUG)



" ==========================================
" # Interface
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-asterisk'
Plug 'rhysd/accelerated-jk'
Plug 't9md/vim-quickhl'
Plug 'junegunn/vim-peekaboo'


Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" for file find and all Denite stuff
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/junkfile.vim'
Plug 'chemzqm/unite-location'
Plug 'chemzqm/denite-git'


" for tagging
Plug 'ludovicchabant/vim-gutentags'
" tagbar for all the tags
Plug 'majutsushi/tagbar'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
" For Linting
Plug 'neomake/neomake'
" for tmux to move around with hjkl
Plug 'christoomey/vim-tmux-navigator'
" Loading custom VIMrc per project
Plug 'embear/vim-localvimrc'


" ==========================================
" Lanuage specifics
" C++ 
Plug 'octol/vim-cpp-enhanced-highlight'


" ==========================================
" Completion
" Python related
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-scripts/python_match.vim', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }


" " ============ Deoplete completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " general syntax completion
" Plug 'Shougo/neco-syntax'
" " for 'include' and 'file'/include'
" Plug 'Shougo/neoinclude.vim'
" " C++ completion
" Plug 'Shougo/deoplete-clangx'
" " Plug 'deoplete-plugins/deoplete-clang'
" " Plug 'tweekmonster/deoplete-clang2'
" " GO completion
" Plug 'deoplete-plugins/deoplete-go'
" " Python Completion
" " Plug 'deoplete-plugins/deoplete-jedi'
" " Tag completion
" Plug 'deoplete-plugins/deoplete-tag'


" ============ COC completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ============ clang_complete completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " ====== vim-clang
" TODO has potential to have fast c++ completion
" Plug 'justmao945/vim-clang'

" ============ async complete ======
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Plug 'Shougo/neco-vim'

" Plug 'prabirshrestha/asyncomplete-necovim.vim'
" 	depends: asyncomplete.vim
" 	hook_source: |
" 		autocmd User asyncomplete_setup call asyncomplete#register_source(
"			\ asyncomplete#sources#necovim#get_source_options({
"			\ 'name': 'necovim',
"			\ 'whitelist': ['vim'],
"			\ 'completor': function('asyncomplete#sources#necovim#completor'),
"			\ }))

Plug 'prabirshrestha/asyncomplete-tags.vim'

Plug 'prabirshrestha/asyncomplete-file.vim'
" 	depends: asyncomplete.vim
" 	hook_source: |
" 		autocmd User asyncomplete_setup call asyncomplete#register_source(
"			\ asyncomplete#sources#file#get_source_options({
"			\ 'name': 'file',
"			\ 'priority': 10,
"			\ 'whitelist': ['*'],
"			\ 'blacklist': ['denite-filter', 'clap_input'],
"			\ 'completor': function('asyncomplete#sources#file#completor')
"			\ }))

" Plug 'wellle/tmux-complete.vim'
" 	if: "! (has('win32') || has('win64'))"
" 	depends: asyncomplete.vim
" 	hook_add: |
" 		let g:tmuxcomplete#trigger = ''
" 		let g:tmuxcomplete#asyncomplete_source_options = {
"			\ 'name': 'tmux',
"			\ 'priority': 0,
"			\ 'whitelist': ['*'],
"			\ 'blacklist': ['denite-filter', 'clap_input'],
"			\ 'config': {
"			\   'splitmode': 'words',
"			\   'filter_prefix': 1,
"			\   'show_incomplete': 1,
"			\   'sort_candidates': 0,
"			\   'scrollback': 0,
"			\   'truncate': 0
"			\   }
"			\ }

" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
" 	depends: asyncomplete.vim
" 	if: has('python3')
" 	hook_source: |
" 		autocmd User asyncomplete_setup call asyncomplete#register_source(
"			\ asyncomplete#sources#ultisnips#get_source_options({
"			\ 'name': 'snip',
"			\ 'priority': 0,
"			\ 'whitelist': ['*'],
"			\ 'blacklist': ['denite-filter', 'clap_input'],
"			\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
"			\ }))

" Plug 'SirVer/ultisnips'
" 	if: has('python3')
" 	on_event: FileType
" 	hook_add: |
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsListSnippets = ''
let g:UltiSnipsJumpForwardTrigger = '<C-f>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

Plug 'honza/vim-snippets'
" 	depends: ultisnips
" 	on_event: FileType
" 	if: has('python3')
" 	merged: 0

" Plug 'dense-analysis/ale'
" 	on_event: FileType
" 	hook_add: |
" 		let g:ale_disable_lsp = 0
" 		let g:ale_echo_delay = 100
" 		let g:ale_lint_delay = 1000
" 		let g:ale_echo_msg_format = '%linter%: %code: %%s [%severity%]'
" 		let g:ale_history_enabled = 0
" 		let g:ale_sign_error = '✖'
" 		let g:ale_sign_warning = 'ⁱ'
" 		let g:ale_maximum_file_size = 500000

" ==================================
" Debugger

Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }


" ===================================
" formatting
Plug 'sbdchd/neoformat'


" ==========================================
" Odds and Ends
Plug 'mechatroner/rainbow_csv'
Plug 'vimwiki/vimwiki'

" ==========================================
" Text-objects - use by other plugins

call plug#end()

filetype plugin indent on
syntax enable



""" PLUGINS END """"


" Always source these
source $VIMPATH/config/general.vim
source $VIMPATH/config/all.vim
" source $VIMPATH/config/completion.vim
source $VIMPATH/config/filetype.vim
source $VIMPATH/config/utils.vim
source $VIMPATH/config/tabline.vim
source $VIMPATH/config/linting.vim
source $VIMPATH/config/looks.vim

" plugin specific settings
" source $VIMPATH/config/plugins/clang_complete.vim

source $VIMPATH/config/plugins/asyncomplete.vim
source $VIMPATH/config/plugins/lsp-settings.vim

" source $VIMPATH/config/plugins/lsp.vim

" source $VIMPATH/config/plugins/deoplete.vim

" source $VIMPATH/config/plugins/coc.vim
" source $VIMPATH/config/plugins/ctrlp.vim
" source $VIMPATH/config/plugins/denite.vim
source $VIMPATH/config/plugins/gutentags.vim
source $VIMPATH/config/plugins/neovim.vim
source $VIMPATH/config/plugins/nerdtree.vim
source $VIMPATH/config/plugins/sneak.vim
source $VIMPATH/config/plugins/vimwiki.vim
source $VIMPATH/config/plugins/nerdtree.vim
source $VIMPATH/config/plugins/easymotion.vim
source $VIMPATH/config/plugins/localrc.vim
source $VIMPATH/config/plugins/tagbar.vim
source $VIMPATH/config/plugins/fzf.vim
source $VIMPATH/config/plugins/termdebug.vim

set termguicolors

" vim: set ts=2 sw=2 tw=80 noet :
