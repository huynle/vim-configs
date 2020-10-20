" Neomake
" ---------
" NOTE: Neomake will not run until the ":Neomake" command is used
"
let g:neomake_open_list = 0
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 0

if ! empty(g:python3_host_prog)
	let g:neomake_python_python_exe = g:python3_host_prog
endif


" when to activate neomake
" call neomake#configure#automake('nrw', 50)


" " JAVASCRIPT / JSX
" let g:neomake_jsx_enabled_makers = ['eslint']
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'

" " YAML / ANSIBLE
" let g:neomake_yaml_enabled_makers = ['yamllint']
" let g:neomake_ansible_enabled_makers = ['yamllint']
" let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

let g:lint_filetypes = [
	\  'python', 'vim', 'go', 'sh',
	\  'javascript', 'json', 'css',
	\  'markdown', 'html', 'yaml', 'c', 'cpp'
	\ ]

""" PYTHON RELATED
let g:neomake_python_pylint_exe = expand('$HOME/.pyenv/versions/neovim/bin/pylint')
let g:neomake_python_flake8_exe = expand('$HOME/.pyenv/versions/neovim/bin/flake8')
" let g:neomake_python_pylint_exe = 'pylint'
" let g:neomake_python_flake8_exe = 'flake8'

" which linter to enable for Python source file linting
let g:neomake_python_enabled_makers = ['flake8', 'pylint']
let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '--rcfile', expand("$PWD/pylintrc"),
  \ '--disable', 'C0103, C0111',
  \ '--format', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '--report', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }

let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }


" ###### RUNNING
" Add an auto command that automatically run Neomake when saving a buffer
autocmd MyAutoCmd BufWritePost *
	\ if index(g:lint_filetypes, &filetype) > -1 && empty(&buftype)
	\|   Neomake
	\| elseif &filetype =~ 'html'
	\|   Neomake tidy
	\| endif
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
