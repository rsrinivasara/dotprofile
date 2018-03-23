call plug#begin('~/.local/share/nvim/plugged')

let g:plug_url_format = 'https://github.com/%s.git'

Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'freeo/vim-kalisi'
Plug 'sheerun/vim-polyglot'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'zchee/deoplete-jedi'

Plug 'Shougo/denite.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'derekwyatt/vim-fswitch'
Plug 'scrooloose/nerdcommenter'

Plug 'Valloric/ListToggle'

call plug#end()
