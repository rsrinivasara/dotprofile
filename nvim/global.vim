" be 'modern'
set nocompatible
syntax on
filetype plugin indent on

" prevent vim from adding that stupid empty line at the end of every file
set noeol
set binary

" utf-8/unicode support
" requires Vim to be compiled with Multibyte support, you can check that by
" running `vim --version` and checking for +multi_byte.
if has('multi_byte')
  scriptencoding utf-8
  set encoding=utf-8
  set termencoding=utf-8
end

" presentation settings
set number              " precede each line with its line number
set numberwidth=3       " number of culumns for line numbers
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmode            " always show what mode we're currently editing in
set ruler               " line and column number of the cursor position
set wildmenu            " make tab completion for files/buffers act like bash
set wildmode=longest,list,full  " Use readline-like tab completion.
set noerrorbells visualbell t_vb=
set laststatus=2        " always show the status line
"set listchars=tab:▷⋅,trail:·,eol:$
set listchars=tab:▷⋅,trail:·
set list

set textwidth=79
set colorcolumn=80
" colorscheme default
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%80v', 100)

" highlight spell errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black

" behavior
                        " ignore these files when completing names and in
                        " explorer
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set shell=/bin/bash     " use bash for shell commands
set autowriteall        " Automatically save before commands like :next and :make
set hidden              " enable multiple modified buffers
set history=1000
set autoread            " automatically read file that has been changed on disk and doesn't have changes in vim
set backspace=indent,eol,start
set guioptions-=T       " disable toolbar"
set completeopt=menuone,preview
let bash_is_sh=1        " syntax shell files as bash scripts
set cinoptions=:0,(s,u0,U1,g0,t0 " some indentation options ':h cinoptions' for details
set modelines=5         " number of lines to check for vim: directives at the start/end of file
"set fixdel                 " fix terminal code for delete (if delete is broken but backspace works)
set autoindent          " automatically indent new line

set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set copyindent                  " copy the previous indentation on autoindenting
set smartindent

:%retab
set smarttab                    " insert tabs on the start of a line according to
                                " shiftwidth, not tabstop

set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to invalid  aces


set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                " paste mode, where you can paste mass data
                                " that won't be autoindented

set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                " with 1-letter words (looks stupid)

" mouse settings
if has("mouse")
  set mouse=a
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif
set mousehide                           " Hide mouse pointer on insert mode."

" search settings
set incsearch           " Incremental search
set hlsearch            " Highlight search match
set ignorecase          " Do case insensitive matching
set smartcase           " do not ignore if search pattern has CAPS

set t_Co=256


" omni completion settings
set ofu=syntaxcomplete#Complete

" directory settings
silent !mkdir -vp ~/.backup/undo/ > /dev/null 2>&1
set backupdir=~/.backup,.       " list of directories for the backup file
set directory=~/.backup,~/tmp,. " list of directory names for the swap file
set nobackup            " do not write backup files
set noswapfile          " do not write .swp files
set undofile
set undodir=~/.backup/undo/,~/tmp,.

" folding
set foldcolumn=0        " columns for folding
set foldmethod=indent
set foldlevel=9
set nofoldenable        "dont fold by default "

" extended '%' mapping for if/then/else/end etc
runtime macros/matchit.vim

let mapleader = ","
let maplocalleader = "\\"

" Always switch to the current file directory
if ! &diff
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endif

" Strip Whitespace
function! StripTrailingWhitespace()
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.local file:
    "   let g:spf13_keep_trailing_whitespace = 1

    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Align function args
set cino+=(0

function! IndentNamespace()
  let l:cline_num = line('.')
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)
  let l:retv = cindent('.')
  while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
    let l:pline_num = prevnonblank(l:pline_num - 1)
    let l:pline = getline(l:pline_num)
  endwhile

  if l:pline =~# '^\s*namespace.*'
    let l:retv = 0
  endif

  return l:retv
endfunction

setlocal indentexpr=IndentNamespace()

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim

nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

"Use semi-colon instead of colon, saves shift key press"

nnoremap ; :
vnoremap ; :

nnoremap j gj
nnoremap k gk

nmap <silent> ,/ :nohlsearch<CR>

" Need to fine tune the auto save so that it does not autosave readonly buffers"
" au FocusLost * :wa

nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>= <C-w>=

" Maps for jj to act as Esc

ino jj <esc>
cno jj <c-c>

" shortcut to toggle spelling
nmap <leader>s :setlocal spell! spelllang=en_us<CR>

" Quickly close the current window
nnoremap <leader>q :q<CR>
nnoremap <leader>w :qa!<CR>

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)

nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Quick yanking to the end of the line
nnoremap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
nnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P

function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction

vnoremap <C-a> :call Incr()<CR>

" Capatalize current word
vnoremap \ U
" nnoremap <c-U> viwU

" Quick alignment of text
nnoremap <leader>al :left<CR>
nnoremap <leader>ar :right<CR>
nnoremap <leader>ac :center<CR>

nnoremap <F3> :buffers<CR>:buffer<SPACE>

"To List all default bindings :help index
"To list current mapping      :map or :map!
"To redirect output to file
":redir! > vim_maps.txt
":map
"":map!
":redir END

