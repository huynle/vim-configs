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

" JAVASCRIPT / JSX
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'

" YAML / ANSIBLE
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_ansible_enabled_makers = ['yamllint']
let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

let g:lint_filetypes = [
	\  'ansible', 'python', 'php', 'ruby', 'vim', 'go', 'sh',
	\  'javascript', 'jsx', 'javascript.jsx', 'json', 'css',
	\  'markdown', 'html', 'yaml', 'c', 'cpp'
	\ ]

" Add an auto command that automatically run Neomake when saving a buffer
autocmd MyAutoCmd BufWritePost *
	\ if index(g:lint_filetypes, &filetype) > -1 && empty(&buftype)
	\|   Neomake
	\| elseif &filetype =~ 'html'
	\|   Neomake tidy
	\| endif
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
