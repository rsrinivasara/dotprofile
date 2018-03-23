call plug#begin('~/.local/share/nvim/plugged')

let g:plug_url_format = 'https://github.com/%s.git'

Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'freeo/vim-kalisi'
Plug 'sheerun/vim-polyglot'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

Plug 'Shougo/denite.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'

call plug#end()
