" enabling popup
let g:asyncomplete_auto_popup = 1

let g:LanguageClient_serverCommands = {
  \ 'python': [expand('$HOME/.pyenv/versions/neovim/bin/pyls')],
  \ }




"""""" trying to get NETRW to work
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" absolute width of netrw window
let g:netrw_winsize = -28

" use the previous window to open file
let g:netrw_browse_split = 4

" tree-view
let g:netrw_liststyle = 3

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

map <silent> <localleader>n :call ToggleVExplorer()<CR>
