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


" ============ Deoplete completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" general syntax completion
Plug 'Shougo/neco-syntax'
" for 'include' and 'file'/include'
Plug 'Shougo/neoinclude.vim'
" C++ completion
" Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-clang'
" GO completion
Plug 'deoplete-plugins/deoplete-go'
" Python Completion
Plug 'deoplete-plugins/deoplete-jedi'
" for tag completion
Plug 'ludovicchabant/vim-gutentags'
Plug 'deoplete-plugins/deoplete-tag'

" ============ COC completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ============ clang_complete completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


" ===================================
" formatting
Plug 'sbdchd/neoformat'

" Snippets
Plug 'SirVer/ultisnips'




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
" source $VIMPATH/config/plugins/asynccomplete.vim
" source $VIMPATH/config/plugins/coc.vim
" source $VIMPATH/config/plugins/ctrlp.vim
" source $VIMPATH/config/plugins/denite.vim
source $VIMPATH/config/plugins/deoplete.vim
source $VIMPATH/config/plugins/gutentags.vim
" source $VIMPATH/config/plugins/lsp-settings.vim
" source $VIMPATH/config/plugins/lsp.vim
source $VIMPATH/config/plugins/neovim.vim
source $VIMPATH/config/plugins/nerdtree.vim
source $VIMPATH/config/plugins/sneak.vim
source $VIMPATH/config/plugins/vimwiki.vim
source $VIMPATH/config/plugins/nerdtree.vim
source $VIMPATH/config/plugins/easymotion.vim
source $VIMPATH/config/plugins/localrc.vim
source $VIMPATH/config/plugins/tagbar.vim
source $VIMPATH/config/plugins/fzf.vim

set termguicolors

" vim: set ts=2 sw=2 tw=80 noet :
