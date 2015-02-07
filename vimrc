" Don’t ensure compatibility with vi at all cost
set nocompatible

" Security
set modeline

" Set the title for the terminal
set title

" Enable syntax
syntax on

" Display a column line after 80 chars
set colorcolumn=80

" Set background to dark
set bg=dark

" Defines the colorscheme that should be used
colorscheme elflord

" display line number and column indicator in a not that strong disturbing color
highlight LineNr ctermfg=grey ctermbg=none
highlight ColorColumn ctermfg=white ctermbg=darkgrey

" For searching
set ignorecase incsearch hlsearch

" beautifully display tabs and trailing spaces
set listchars=tab:¬\ ,trail:· list

" Set encoding to utf-8
set fileencoding=utf-8 encoding=utf-8

" Defines tab and shift width
set expandtab
set tabstop=4 shiftwidth=4

" Show matching brackets
set showmatch

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" Always show statusline and tabline
set laststatus=2
set showtabline=2

" Do not create those annoying backup swap files
set nobackup nowritebackup noswapfile

" Enhanced mode for command-line completion and enable listing possible completions when completing file names
set wildmenu wildmode=longest:full

" Disable folding
set nofoldenable

" Function for toggling through line number modes
function! ToggleLineNumbers()
    if (&number == 0 && &relativenumber == 0)
        set number
    elseif (&number == 1 && &relativenumber == 0)
        set nonumber
        set relativenumber
    elseif (&number == 0 && &relativenumber == 1) && v:version >= 704
        set number
    else
        set nonumber
        set norelativenumber
    endif
endfunc

nnoremap <C-n> :call ToggleLineNumbers()<cr>
