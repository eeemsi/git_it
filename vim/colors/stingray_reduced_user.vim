set background=dark
set t_Co=16
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="stingray"

hi LineNr ctermfg=Darkgrey ctermbg=None

hi Statement    ctermfg=Cyan        ctermbg=None
hi Comment      ctermfg=DarkGrey    ctermbg=None   cterm=bold term=bold
hi Constant     ctermfg=DarkCyan    ctermbg=None
hi Identifier   ctermfg=White       ctermbg=None
hi Type         ctermfg=DarkCyan    ctermbg=None
hi String       ctermfg=Cyan        ctermbg=None
hi Boolean      ctermfg=Cyan        ctermbg=None
hi Number       ctermfg=Cyan        ctermbg=None
hi Folded       ctermfg=DarkCyan    ctermbg=None   cterm=underline term=none
hi Special      ctermfg=Grey        ctermbg=None
hi PreProc      ctermfg=Grey        ctermbg=None   cterm=bold term=bold
hi ErrorMsg     ctermfg=Cyan        ctermbg=None   cterm=bold term=bold
hi WarningMsg   ctermfg=Yellow      ctermbg=None
hi VertSplit    ctermfg=White       ctermbg=None
hi Directory    ctermfg=Green       ctermbg=None
