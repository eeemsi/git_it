set background=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="stingray"
        hi Statement    ctermfg=Yellow      ctermbg=None
        hi Comment      ctermfg=DarkGrey    ctermbg=None   cterm=bold term=bold
        hi Constant     ctermfg=DarkYellow  ctermbg=None
        hi Identifier   ctermfg=White       ctermbg=None
        hi Type         ctermfg=DarkYellow  ctermbg=None
        hi String       ctermfg=Yellow      ctermbg=None
        hi Boolean      ctermfg=Yellow      ctermbg=None
        hi Number       ctermfg=Yellow      ctermbg=None
        hi Folded       ctermfg=DarkYellow  ctermbg=None   cterm=underline term=none
        hi Special      ctermfg=Grey        ctermbg=None
        hi PreProc      ctermfg=Grey        ctermbg=None   cterm=bold term=bold
        hi ErrorMsg     ctermfg=Yellow      ctermbg=None   cterm=bold term=bold
        hi WarningMsg   ctermfg=Yellow      ctermbg=None
        hi VertSplit    ctermfg=White       ctermbg=None
        hi Directory    ctermfg=Green       ctermbg=None
