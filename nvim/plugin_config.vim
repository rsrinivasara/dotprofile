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

" Deoplete-jedi
let g:deoplete#sources#jedi#python_path="/home/rsriniva/bin/nvim_venv3/bin/python"
let g:deoplete#sources#jedi#show_docstring = 1

" Denite
source ~/.nvim/denite_config.vim

" Deoplete-clang
" let g:deoplete#sources#clang#libclang_path




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
