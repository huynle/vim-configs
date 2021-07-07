lua require('plugins.telescope')


" nnoremap <silent><LocalLeader>f :<C-u>Telescope find_files theme=get_dropdown previewer=false<CR>
" nnoremap <silent><LocalLeader>g :<C-u>Telescope live_grep<CR>
" nnoremap <silent><LocalLeader>b :<C-u>Telescope buffers theme=get_dropdown show_all_buffers=true<CR>
" nnoremap <silent><LocalLeader>h :<C-u>Telescope highlights<CR>
" nnoremap <silent><LocalLeader>j :<C-u>Telescope jumplist<CR>
" nnoremap <silent><LocalLeader>m :<C-u>Telescope marks<CR>
" nnoremap <silent><LocalLeader>v :<C-u>Telescope registers<CR>
" nnoremap <silent><LocalLeader>u :<C-u>Telescope spell_suggest<CR>
" " nnoremap <silent><LocalLeader>s :<C-u>Telescope session-lens search_session<CR>
" nnoremap <silent><LocalLeader>x :<C-u>Telescope oldfiles<CR>
" nnoremap <silent><LocalLeader>z :<C-u>Telescope zoxide list<CR>
" nnoremap <silent><LocalLeader>; :<C-u>Telescope command_history<CR>
" nnoremap <silent><LocalLeader>/ :<C-u>Telescope search_history<CR>
" nnoremap <silent> <Leader>gg :Telescope grep_string<CR>




	" git_commits    git_bcommits   git_branches
	" git_status     git_stash      git_files
	" file_browser   tags           fd             autocommands   quickfix
	" filetypes      commands       man_pages      help_tags      loclist
	" lsp_workspace_diagnostics     lsp_document_diagnostics

	nnoremap <silent><LocalLeader>f <cmd>Telescope find_files<CR>
	nnoremap <silent><LocalLeader>g <cmd>Telescope live_grep<CR>
	nnoremap <silent><LocalLeader>b <cmd>Telescope buffers<CR>
	nnoremap <silent><LocalLeader>h <cmd>Telescope highlights<CR>
	nnoremap <silent><LocalLeader>j <cmd>Telescope jumplist<CR>
	nnoremap <silent><LocalLeader>m <cmd>Telescope marks<CR>
	nnoremap <silent><LocalLeader>o <cmd>Telescope vim_options<CR>
	nnoremap <silent><LocalLeader>t <cmd>Telescope lsp_dynamic_workspace_symbols<CR>
	nnoremap <silent><LocalLeader>v <cmd>Telescope registers<CR>
	nnoremap <silent><LocalLeader>u <cmd>Telescope spell_suggest<CR>
	nnoremap <silent><LocalLeader>s <cmd>Telescope session-lens search_session<CR>
	nnoremap <silent><LocalLeader>x <cmd>Telescope oldfiles<CR>
	nnoremap <silent><LocalLeader>z <cmd>Telescope zoxide list<CR>
	nnoremap <silent><LocalLeader>; <cmd>Telescope command_history<CR>
	nnoremap <silent><LocalLeader>/ <cmd>Telescope search_history<CR>
	nnoremap <silent><LocalLeader>n :lua require 'telescope.builtin'.find_files({prompt_title = "plugins", cwd = "$XDG_DATA_HOME/nvim/dein/repos/github.com"})<CR>
	nnoremap <silent><LocalLeader>w :lua require 'telescope.builtin'.find_files({prompt_title = "docs", cwd = "$HOME/docs/blog"})<CR>

	nnoremap <silent><LocalLeader>dd <cmd>Telescope lsp_definitions<CR>
	nnoremap <silent><LocalLeader>di <cmd>Telescope lsp_implementations<CR>
	nnoremap <silent><LocalLeader>dr <cmd>Telescope lsp_references<CR>
	nnoremap <silent><LocalLeader>da <cmd>Telescope lsp_code_actions<CR>
	vnoremap <silent><LocalLeader>da :Telescope lsp_range_code_actions<CR>

	nnoremap <silent> <Leader>/  <cmd>Telescope current_buffer_fuzzy_find<CR>
	nnoremap <silent> <Leader>gt <cmd>Telescope lsp_workspace_symbols default_text=<C-r>=shellescape(expand('<cword>'), 1)<CR><CR>
	nnoremap <silent> <Leader>gf <cmd>Telescope find_files default_text=<C-r>=shellescape(expand('<cword>'), 1)<CR><CR>
	nnoremap <silent> <Leader>gg <cmd>Telescope grep_string<CR>
	vnoremap <silent> <Leader>gg :<C-u>Telescope grep_string default_text=<C-r>=shellescape(<SID>get_selection(), 1)<CR><CR>

	" Returns visually selected text
	function! s:get_selection() abort
		try
			let a_save = @a
			silent! normal! gv"ay
			return substitute(escape(@a, '\/'), '\n', '\\n', 'g')
		finally
			let @a = a_save
		endtry
	endfunction
