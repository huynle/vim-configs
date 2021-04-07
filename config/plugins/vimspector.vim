let g:vimspector_enable_mappings = 'HUMAN'

" Continue
" Stop
" Restart
" Pause
" ToggleBreakpoint
" ToggleConditionalBreakpoint
" AddFunctionBreakpoint
" StepOver
" StepInto
" StepOut
" RunToCursor
" nnoremap <silent> <leader>ds :call vimspector#Reset()<CR>
" nmap <leader>dd <Plug>VimspectorContinue
" nmap dc <Plug>VimspectorContinue

" " nmap d <Plug>VimspectorStop
" " nmap dS <Plug>VimspectorRestart
" nmap dP <Plug>VimspectorPause
" nmap db <Plug>VimspectorToggleBreakpoint
" nmap dB <Plug>VimspectorToggleConditionalBreakpoint
" nmap dbb <Plug>VimspectorAddFunctionBreakpoint
" nmap dn <Plug>VimspectorStepOver
" nmap ds <Plug>VimspectorStepInto
" nmap du <Plug>VimspectorStepOut
" " nmap d <Plug>VimspectorRunToCursor

" " nnoremap <silent> <F5> :call vimspector#Continue()<CR>
" nnoremap <silent> <leader>dd :call vimspector#Continue()<CR>
" nnoremap <silent> <leader>dn :call vimspector#StepOver()<CR>
" nnoremap <silent> <leader>ds :call vimspector#StepInto()<CR>
" nnoremap <silent> <leader>do :call vimspector#StepOut()<CR>
" nnoremap <silent> <leader>b :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <silent> <leader>B :call vimspector#ToggleConditionalBreakpoint()<CR>
" nnoremap <silent> <leader>r :call vimspector#RunToCursor()<CR>
" nnoremap <silent> <leader>dS :call vimspector#Reset()<CR>

" nnoremap <silent> <leader>lp :call require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :call require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :call require'dap'.repl.run_last()<CR>`
"



" Set the basic sizes
let g:vimspector_sidebar_width = 50
let g:vimspector_code_minwidth = 90
let g:vimspector_terminal_minwidth = 75


" https://github.com/David-Kunz/vim/blob/master/init.vim
function! VimspectorPytestStrategy(cmd)
  " let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  " let testName = matchlist(a:cmd, '\v^(.+)(\s+)(\S+)')[3]
  " split by space
  let testName = split(a:cmd, '\v\s')[-1]
  let pytestExec = split(a:cmd, '\v\s')[0]
  let pytestArgs = split(a:cmd, '\v\s')[1:-2]

  call vimspector#LaunchWithSettings( #{ configuration: 'Pytest: Nearest', TestName: testName,  VimTestExec: pytestExec, VimTestArgs: pytestArgs} )
endfunction

let g:test#custom_strategies = {'vimspector_pytest': function('VimspectorPytestStrategy')}

" nnoremap <leader>da :TestNearest -strategy=vimspector_pytest<CR>

func! AddToWatch()
	let word = expand("<cexpr>")
	call vimspector#AddWatch(word)
endfunction
let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')


function! s:CustomiseUI()
  " Customise the basic UI...

  " Close the output windowfunc! CustomiseUI()
  call win_gotoid( g:vimspector_session_windows.code )
  " Clear the existing WinBar created by Vimspector
  nunmenu WinBar
  " Cretae our own WinBar
  nnoremenu WinBar.Kill :call vimspector#Stop()<CR>
  nnoremenu WinBar.Continue :call vimspector#Continue()<CR>
  nnoremenu WinBar.Pause :call vimspector#Pause()<CR>
  nnoremenu WinBar.Step\ Over  :call vimspector#StepOver()<CR>
  nnoremenu WinBar.Step\ In :call vimspector#StepInto()<CR>
  nnoremenu WinBar.Step\ Out :call vimspector#StepOut()<CR>
  nnoremenu WinBar.Restart :call vimspector#Restart()<CR>
  nnoremenu WinBar.Exit :call vimspector#Reset()<CR>

endfunction

"" Credit for saving/restor mappings goes here https://vi.stackexchange.com/questions/7734/how-to-save-and-restore-a-mapping/7735#7735?newreg=fe2f242c9fe546e3999cecee085e3d69

fu! Save_mappings(keys, mode, global) abort
    let mappings = {}

    if a:global
        for l:key in a:keys
            let buf_local_map = maparg(l:key, a:mode, 0, 1)

            sil! exe a:mode.'unmap <buffer> '.l:key

            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 0,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }

            call Restore_mappings({l:key : buf_local_map})
        endfor

    else
        for l:key in a:keys
            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 1,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }
        endfor
    endif

    return mappings
endfu

fu! Restore_mappings(mappings) abort

    for mapping in values(a:mappings)
        if !has_key(mapping, 'unmapped') && !empty(mapping)
            exe     mapping.mode
               \ . (mapping.noremap ? 'noremap   ' : 'map ')
               \ . (mapping.buffer  ? ' <buffer> ' : '')
               \ . (mapping.expr    ? ' <expr>   ' : '')
               \ . (mapping.nowait  ? ' <nowait> ' : '')
               \ . (mapping.silent  ? ' <silent> ' : '')
               \ .  mapping.lhs
               \ . ' '
               \ . substitute(mapping.rhs, '<SID>', '<SNR>'.mapping.sid.'_', 'g')

        elseif has_key(mapping, 'unmapped')
            sil! exe mapping.mode.'unmap '
                                \ .(mapping.buffer ? ' <buffer> ' : '')
                                \ . mapping.lhs
        endif
    endfor

endfu


nnoremap <silent> <leader>dd :call vimspector#Continue()<CR>

" nnoremap <expr> <Plug>BuildAndDebugVimSpector :call vimspector#Launch()<CR>
" nmap <leader>dd <Plug>BuildAndDebugVimSpector

nnoremap <silent> <leader>b :call vimspector#ToggleBreakpoint()<CR>
let g:your_saved_mappings = Save_mappings(['<localleader>R', '<localleader>n', '<localleader>s', '<localleader>o', '<localleader>B', '<localleader>r', '<localleader>c', "<leader>dd"], 'n', 1)

function s:SetUpTerminal()
  " Customise the terminal window size/position
  " For some reasons terminal buffers in Neovim have line numbers
  " call win_gotoid( g:vimspector_session_windows.terminal )
  " set norelativenumber nonumber

	nnoremap <silent> <localleader>c :call vimspector#Continue()<CR>
	nnoremap <silent> <localleader>n :call vimspector#StepOver()<CR>
	nnoremap <silent> <localleader>s :call vimspector#StepInto()<CR>
	nnoremap <silent> <localleader>o :call vimspector#StepOut()<CR>
	nnoremap <silent> <localleader>B :call vimspector#ToggleConditionalBreakpoint()<CR>
  nnoremap <silent> <localleader>b :call vimspector#ToggleBreakpoint()<CR>
	nnoremap <silent> <localleader>r :call vimspector#RunToCursor()<CR>
	nnoremap <silent> <localleader>R :call vimspector#Restart()<CR>
  nnoremap <silent> <localleader>w :call AddToWatch()<CR>
	nnoremap <silent> <leader>dd :<C-u>call VimspectorCloseAndRestore()<CR>
  nnoremap <silent> <localleader>u :call VimspectorUpFrame()<CR>
  nnoremap <silent> <localleader>d :call VimspectorDownFrame()<CR>

endfunction

function VimspectorCloseAndRestore()
  call Restore_mappings(g:your_saved_mappings)
	call vimspector#Reset()
endfunction


augroup MyVimspectorUICustomistaion
  autocmd!
  " autocmd User VimspectorUICreated call s:CustomiseUI()
  autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
augroup END
