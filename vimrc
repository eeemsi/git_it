" Should be given by the machine vim is installed on
runtime! debian.vim

" Enable colors for syntax and use dark background
syntax on
set bg=dark

" Display the cursorline and disable visual bell
set cursorline
set novisualbell

" Defines the colorscheme that should be used
colorscheme elflord

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Always show the statusline
set laststatus=2

" Format the statusline - GitBranchInfoString() requires github.com/taq/vim-git-branch-info to work
set statusline=\ %F%m%r%h\ %w\ >\ \ %{GitBranchInfoString()}\ >\ Line:\ %l/%L:%c
set showcmd

" Enhanced mode for command-line completion
set wildmenu

" Enable listing possible completions when completing file names
set wildmode=longest,list:longest,list:full

" Skip certain endings while completing
set wildignore=*.o,*.a,*.la,*.lo,*.swp,*.tab.c,*.tab.h,*.yy.c,.svn,.git

" Set the titel for the terminal
set title

" For searching
set ignorecase
set incsearch
set hlsearch

" Defines tab and shift width
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" More flexible backspace
set backspace=indent,eol,start

" Handle long lines correctly and smart
set wrap
set autoindent smartindent

" Fast paste mode toggling
set pastetoggle=<F12>

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" Show matching brackets
set showmatch

" Security
set modelines=0

" Don’t ensure compatibility with vi at all cost
set nocompatible

" For fast terminal connection
set ttyfast

" Disable folding completely
set nofen

" When .vimrc is edited, automatically reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

