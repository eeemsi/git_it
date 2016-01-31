" Don’t ensure compatibility with vi at all cost
set nocompatible

" Security
set nomodeline

" Disable mouse input
set mouse=

" Set the title for the terminal
set title

" No beep
set noerrorbells visualbell t_vb=

" Always show laststatus and the position of cursor
set laststatus=2

" Enable syntax
syntax on

" Defines the colorscheme that should be used
colorscheme stingray_reduced

" hybrid line numbers
set number relativenumber

" For searching
set ignorecase incsearch hlsearch

" beautifully display tabs and trailing spaces
set list listchars=tab:.\ ,trail:.

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Tabs are spaces
set tabstop=4 shiftwidth=4 expandtab

" More powerful backspacing
set backspace=indent,eol,start

" Show matching brackets
set showmatch

" Do not create those annoying backup swap files
set nobackup nowritebackup noswapfile

" Enhanced mode for command-line completion and enable listing possible completions when completing file names
set wildmenu wildmode=longest:full

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''
