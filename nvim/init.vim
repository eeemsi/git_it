" disable modeline for security
set nomodeline

" Set the title of the window to the value of 'titlestring'
set title

" Only draw a status line if there are at least two windows
set laststatus=1

" Highlight the screen line of the cursor
set cursorline

" Ignore case in search patterns
set ignorecase

" 80 characters visible indicator
highlight ColorColumn ctermbg=none ctermfg=red
set colorcolumn=80

" Enable list mode. Useful to see the difference between tabs and spaces and
" for trailing blanks
set list

" Number of spaces that a tab in the file counts for
set tabstop=4 shiftwidth=4

" Suppress the banner in netrw
let g:netrw_banner=0

" Tree style listing in netrw
let g:netrw_liststyle = 3

" Automatically remove trailing whitespace
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm '
