" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
"
let test#preserve_screen = 1
let test#python#pytest#executable = '~/.pyenv/versions/efi/bin/py.test'
let test#python#runner = 'pytest'
let test#vim#term_position = "belowright"

let test#strategy = {
  \ 'nearest': 'neomake',
  \ 'file':    'neomake',
  \ 'suite':   'basic',
\}

let test#python#pytest#options = {
  \ 'nearest': '',
  \ 'file':    '',
  \ 'suite':   '-s',
\}

"
"
" basic here allow for debugging
nmap <leader>td :TestNearest -strategy=basic<CR>
nmap <leader>tn :TestNearest<CR>
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
