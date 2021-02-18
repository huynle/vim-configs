"""""""""""""" This file has to do with syntax and formatting

" """"" Syntastic
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_check_no_defaults_include_dirs = 0
let g:syntastic_cpp_auto_refresh_includes = 1
" let g:syntastic_cpp_include_dirs = [ 'includes', 'headers' ]
" let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_config_file = '.clang_complete'

""" Python stuff
let g:syntastic_python_checkers = ['pylint']

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["cpp", "py"],
    \ "passive_filetypes": ["rbql"] }



 " Toggle auto syntax checking
nmap <Leader><Leader>ss :SyntasticToggleMode<CR>

