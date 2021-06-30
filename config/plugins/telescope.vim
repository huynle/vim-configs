lua require('plugins.telescope')


nnoremap <silent><LocalLeader>f :<C-u>Telescope find_files theme=get_dropdown previewer=false<CR>
nnoremap <silent><LocalLeader>g :<C-u>Telescope live_grep<CR>
nnoremap <silent><LocalLeader>b :<C-u>Telescope buffers theme=get_dropdown show_all_buffers=true<CR>
nnoremap <silent><LocalLeader>h :<C-u>Telescope highlights<CR>
nnoremap <silent><LocalLeader>j :<C-u>Telescope jumplist<CR>
nnoremap <silent><LocalLeader>m :<C-u>Telescope marks<CR>
nnoremap <silent><LocalLeader>v :<C-u>Telescope registers<CR>
nnoremap <silent><LocalLeader>u :<C-u>Telescope spell_suggest<CR>
" nnoremap <silent><LocalLeader>s :<C-u>Telescope session-lens search_session<CR>
nnoremap <silent><LocalLeader>x :<C-u>Telescope oldfiles<CR>
nnoremap <silent><LocalLeader>z :<C-u>Telescope zoxide list<CR>
nnoremap <silent><LocalLeader>; :<C-u>Telescope command_history<CR>
nnoremap <silent><LocalLeader>/ :<C-u>Telescope search_history<CR>
nnoremap <silent> <Leader>gg :Telescope grep_string<CR>
