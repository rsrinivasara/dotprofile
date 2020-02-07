" Deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" LanguageClient
let g:LanguageClient_serverCommands = {
\ 'cpp': ['/home/ram/repos/cquery/build/release/bin/cquery', '--language-server', '--log-file=/tmp/cq.log']
\ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/ram/.config/nvim/cquery_settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Deoplete-jedi
" let g:deoplete#sources#jedi#python_path="/Users/rsrinivasara/tools/nvim_venv3/bin/python"
let g:deoplete#sources#jedi#python_path="//Users/rsrinivasara/tools/edx_venv/bin/python3"
let g:deoplete#sources#jedi#show_docstring = 1
autocmd CompleteDone * silent! pclose!


" Denite
source ~/.nvim/denite_config.vim

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_theme= 'kalisi'

"------------------------------------------------------------------------------
" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>

"------------------------------------------------------------------------------
" vim-fswitch - Easily switch between header and cpp files
nmap <Leader>fh :FSHere<CR>
nmap <Leader>fl :FSLeft<CR>
nmap <Leader>fr :FSRight<CR>

"------------------------------------------------------------------------------
" ListToggle - Easily switch between header and cpp files

let g:lt_location_list_toggle_map = '<LocalLeader>l'
let g:lt_quickfix_list_toggle_map = '<LocalLeader>q'
