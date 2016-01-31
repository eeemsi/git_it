set background=dark
set t_Co=16
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="stingray"

hi LineNr       ctermfg=Darkgrey
hi Normal       ctermfg=White
hi NonText      ctermfg=DarkGray

hi ErrorMsg     ctermfg=Red
hi WarningMsg   ctermfg=Yellow

hi Statement    ctermfg=Cyan
hi Comment      ctermfg=DarkGrey
hi Constant     ctermfg=DarkCyan
hi Identifier   ctermfg=White
hi Type         ctermfg=DarkCyan
hi String       ctermfg=Cyan
hi Boolean      ctermfg=Cyan
hi Number       ctermfg=Cyan
hi Folded       ctermfg=DarkCyan    cterm=underline
hi Special      ctermfg=Grey
hi PreProc      ctermfg=Grey
hi VertSplit    ctermfg=White
