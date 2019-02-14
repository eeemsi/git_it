" Do not ensure compatibility with vi at all cost
set nocompatible

" Ignore modelines completely
set nomodeline

" Disable mouse usage in all modes
set mouse=

" Set the title for the terminal
set title

" No beep
set belloff=all

" Enable syntax highlighting
syntax enable
set background=dark
colorscheme elflord

" Define number of colors
set t_Co=256

" 80 characters visible indicator
highlight ColorColumn ctermbg=none ctermfg=red
set colorcolumn=80

" Enable screen line that the cursor is in
set cursorline

" For searching
set ignorecase incsearch hlsearch

" beautifully display tabs and trailing spaces
set list listchars=tab:.\ ,trail:.

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Tabs are spaces
set tabstop=4 shiftwidth=4 expandtab

" Show matching brackets
set showmatch

" Do not create those annoying backup swap files
set nobackup nowritebackup noswapfile

" Enhanced command-line completion
set wildmenu wildmode=longest:full

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm '
