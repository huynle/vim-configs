nnoremap <leader>ca :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>cl :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>cs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>cg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>cd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>cc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ct :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>ce :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>cf :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>ci :call CscopeFind('i', expand('<cword>'))<CR>
