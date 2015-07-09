" Don’t ensure compatibility with vi at all cost
set nocompatible

" Security
set modeline

" Set the title for the terminal
set title

" Always show statusline, tabline and the cursor position
set laststatus=2 showtabline=2 ruler

" Enable syntax
syntax on

" Defines the colorscheme that should be used
colorscheme stingray_reduced

" hybrid line numbers
if (v:version >= 704)
    highlight LineNr ctermfg=Darkgrey ctermbg=None
    set number relativenumber
endif

" For searching
set ignorecase incsearch hlsearch

" beautifully display tabs and trailing spaces
set listchars=tab:¬\ ,trail:· list

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Defines tab and shift width
set expandtab
set tabstop=4 shiftwidth=4

" More powerful backspacing
set backspace=indent,eol,start

" Show matching brackets
set showmatch

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" Do not create those annoying backup swap files
set nobackup nowritebackup noswapfile

" Enhanced mode for command-line completion and enable listing possible completions when completing file names
set wildmenu wildmode=longest:full
