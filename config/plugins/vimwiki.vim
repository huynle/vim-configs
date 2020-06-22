"""""" Vimwiki 
let g:vimwiki_use_calendar = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_tags_header = 'Generated Tags'
let g:vimwiki_markdown_header_style = 0
let g:vimwiki_autowriteall = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_html_header_numbering = 1
let g:vimwiki_html_header_numbering_sym = '.'
let g:vimwiki_list = [
\   { 'diary_header': 'Daily',
\     'diary_caption_level': -1,
\     'links_space_char': '-',
\     'auto_diary_index': 1,
\     'auto_toc': 0,
\     'auto_tags': 1,
\     'auto_generate_tags': 1,
\     'auto_generate_links': 1,
\     'path': '~/docs/wiki/',
\     'exclude_files': ['**/README.md'],
\     'syntax': 'markdown',
\     'ext': '.md' },
\   { 'path': '~/docs/orion/',
\     'links_space_char': '_',
\     'syntax': 'markdown',
\     'ext': '.md' }
\ ]


" nnoremap <silent> <Leader>W :<C-u>VimwikiTabIndex<CR>
nnoremap <silent> <Leader>W :<C-u>VimwikiIndex<CR>

