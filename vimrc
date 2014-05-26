" Don’t ensure compatibility with vi at all cost
set nocompatible

" Security
set modeline

" Should be given by the machine vim is installed on
runtime! debian.vim

" Enable colors for syntax and use dark background
syntax on
set bg=dark

" Enable syntax highlighting for go
autocmd BufNewFile,BufRead *.go setf go

" Use system configurations
set runtimepath+=/usr/share/vim/addons

" Enable file type-specific indention rules
filetype plugin indent on

" Display the cursorline and columnline
set cursorline
set cursorcolumn

" Display the columnline as configured below
" This feature seems to be available since vim 7.3
if exists("+colorcolumn")
	set cc=80
endif

" Disable visual bell and please stop whining
set novisualbell
set noerrorbells
set vb t_vb=

" Defines the colorscheme that should be used
colorscheme elflord

" Define another color for CursorColumn
hi CursorColumn ctermbg=grey ctermfg=black

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Always show the statusline
set laststatus=2

" Ignore remote remote branches
let g:git_branch_status_ignore_remotes=1

" Format the statusline - GitBranchInfoString() requires github.com/taq/vim-git-branch-info to work
set statusline=
set statusline+=\[%F]
set statusline+=\%r%m
set statusline+=\[%{GitBranchInfoTokens()[0]}]
set statusline+=\%=
set statusline+=\[%3p%%]
set statusline+=\[%3l:%3c]

set showcmd

" Enhanced mode for command-line completion
set wildmenu

" Enable listing possible completions when completing file names
set wildmode=longest:full

" Skip certain endings while completing
set wildignore=*.o,*.a,*.la,*.lo,*.swp,.svn,.git,*.pyc,*.pyo

" Set the titel for the terminal
set title

" For searching
set ignorecase
set incsearch
set hlsearch

" Defines tab and shift width
set tabstop=4
set shiftwidth=4
set noexpandtab

" More flexible backspace
set backspace=indent,eol,start

" Handle long lines correctly and smart
set wrap
set autoindent smartindent

" beautifully display tabs and trailing spaces
set listchars=tab:\|\ ,trail:·
set list

" Fast paste mode toggling
set pastetoggle=<F12>

" Faster switching for tabs
map <F7> :tabp<ENTER>
map <F8> :tabn<ENTER>

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" Show matching brackets
set showmatch

" For fast terminal connection
set ttyfast

" Define some settings for folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable

" Do not create those annoying backup files
set nobackup
set nowritebackup

" No spell check
set nospell

" Try to get rid of weird delays
set timeout timeoutlen=1000 ttimeoutlen=100

" Define the path for swap and backup files
set directory=/tmp
set backupdir=/tmp

" When .vimrc is edited, automatically reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
