"""""""""""""""""""" Running rsync on save"
" rsync
function! RemoteSync (sync_type)
	if !exists("b:enable_rsync") || b:enable_rsync == 0
		return
	endif
	" u for Update
	" t for copying time also
	" r for recursive
  "
  " TODO to update this to automatically strip off the trailing slashes
  
  if !exists("b:rsync_extra_args")
      let b:rsync_extra_args = ""
  endif

	if a:sync_type == "write"
		let rsync_command = "rsync -art ".b:rsync_extra_args." --exclude-from=".b:rsync_local."/".b:rsync_exclude." ".b:rsync_local."/ ".b:rsync_server.":".b:rsync_remote." &"
  elseif a:sync_type == "write-delete"
		let rsync_command = "rsync -art ".b:rsync_extra_args." --exclude-from=".b:rsync_local."/".b:rsync_exclude." ".b:rsync_local."/ ".b:rsync_server.":".b:rsync_remote." --delete &"
	elseif a:sync_type == "read"
		let rsync_command = "rsync -art ".b:rsync_extra_args." --exclude-from=".b:rsync_local."/".b:rsync_exclude." ".b:rsync_server.":".b:rsync_remote."/ ".b:rsync_local." &"
	elseif a:sync_type == "read-delete"
		let rsync_command = "rsync -art ".b:rsync_extra_args." --exclude-from=".b:rsync_local."/".b:rsync_exclude." ".b:rsync_server.":".b:rsync_remote."/ ".b:rsync_local." --delete &"
	elseif a:sync_type == "read-delete-no-exclude"
		let rsync_command = "rsync -art ".b:rsync_server.":".b:rsync_remote." ".b:rsync_local."/ --delete &"
	endif

  " execute "!" . rsync_command
	execute "!" . rsync_command
	" execute "!" . rsync_command_reverse

	" turn off rsync until it is loaded again by .local.vimrc
endfunction

" bind K to grep word under cursor
nnoremap <silent> <Leader>sw :call RemoteSync("write")<CR>
nnoremap <silent> <Leader>swd :call RemoteSync("write-delete")<CR>
nnoremap <silent> <Leader>sr :call RemoteSync("read")<CR>
nnoremap <silent> <Leader>srd :call RemoteSync("read-delete")<CR>
nnoremap <silent> <Leader>srdd :call RemoteSync("read-delete-no-exclude")<CR>
" au BufWritePost,FileWritePost * silent call RemoteSync()

