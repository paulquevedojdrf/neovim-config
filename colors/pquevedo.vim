runtime colors/default.vim

" Whitespace characters (Trailing spaces or tabs etc..)
highlight Whitespace ctermfg=red guifg=red

syn match Todo /FIXME/
syn match Todo /TODO/

hi User1 term=NONE ctermfg=yellow       ctermbg=darkgrey
hi User2 term=NONE ctermfg=green        ctermbg=darkgrey
hi User3 term=NONE ctermfg=Blue         ctermbg=darkgrey
hi User4 term=NONE ctermfg=cyan         ctermbg=darkgrey
hi User5 term=NONE ctermfg=yellow       ctermbg=darkgrey
hi User6 term=NONE ctermfg=red          ctermbg=darkgrey

hi CursorLine gui=underline cterm=underline
hi Directory term=NONE ctermfg=LightCyan
hi Comment term=NONE ctermfg=LightGreen
hi Constant term=NONE ctermfg=Magenta
hi String term=NONE ctermfg=DarkRed
hi Chracter term=NONE ctermfg=Yellow
hi Number term=NONE ctermfg=Yellow
hi Boolean term=NONE ctermfg=Yellow
hi Float term=NONE ctermfg=Yellow
"hi Identifier term=NONE ctermfg=Magenta
hi Function term=NONE ctermfg=Magenta
hi Statement term=NONE ctermfg=red
hi Conditional term=NONE ctermfg=Magenta
hi Repeat term=NONE ctermfg=White
hi Label term=NONE ctermfg=White
hi Operator term=NONE ctermfg=LightCyan
hi Keyword term=NONE ctermfg=White
hi Exception term=NONE ctermfg=White
hi PreProc term=NONE ctermfg=Gray
hi Include term=NONE ctermfg=White
hi Define term=NONE ctermfg=LightCyan
hi Macro term=NONE ctermfg=Yellow
hi PreCondit term=NONE ctermfg=LightCyan
hi Type term=NONE ctermfg=LightCyan
hi StorageClass term=NONE ctermfg=Cyan
hi Structure term=NONE ctermfg=LightCyan
hi Typedef term=NONE ctermfg=LightCyan
hi Special term=NONE ctermfg=White
hi SpecialChar term=NONE ctermfg=Cyan
hi Tag term=NONE ctermfg=Cyan
hi Delimiter term=NONE ctermfg=Blue
hi SpecialComment term=NONE ctermfg=LightGreen
hi Debug term=NONE ctermfg=Red
hi Ignore term=NONE ctermfg=Red
hi Error term=NONE ctermfg=Red
hi Todo term=bold ctermbg=yellow

" Folding Highlights disabled
highlight Folded     ctermbg=none ctermfg=none
highlight FoldColumn ctermbg=none ctermfg=none

" Global highlighting overrides
highlight Comment      ctermfg=grey
highlight Constant     ctermfg=white
highlight Search       ctermfg=darkgrey     ctermbg=yellow  term=bold
highlight Special      ctermfg=cyan
highlight StatusLine   ctermfg=darkgrey     ctermbg=green   term=none
highlight StatusLineNC ctermfg=darkgrey     ctermbg=darkred term=none
highlight VertSplit    ctermfg=darkgrey     ctermbg=darkgrey
highlight ErrorMsg     ctermfg=red          ctermbg=black
highlight Error        ctermfg=red          ctermbg=black
highlight WarningMsg   ctermfg=yellow       cterm=standout
highlight SpellBad     ctermfg=red          ctermbg=black       cterm=underline

" C syntax highlighting overrides
highlight cDefine      ctermfg=yellow
highlight cInclude     ctermfg=white
highlight cFormat      ctermfg=cyan
highlight cType        ctermfg=cyan
highlight cPreCondit   ctermfg=blue
highlight cSpecial     ctermfg=red
highlight cNumber      ctermfg=yellow
highlight cConstant    ctermfg=magenta
"highlight cFloat       ctermfg=magenta
highlight cCharacter   ctermfg=blue
highlight cString      ctermfg=darkred
highlight cStatement   ctermfg=red
highlight cComment     ctermfg=green

function! s:pquevedo_AddCCodeHighlighting()
    " Highlight C typedefs and structs (_t, _s)
    syntax match cType /\w\+_t\ze\W/
    syntax match cType /\w\+_s\ze\W/

    syntax match ifType /\w\+IF_t/
    highlight ifType ctermfg=yellow

    syntax match ctxType /\w\+Ctx_t/
    highlight ctxType ctermfg=magenta

    syntax match pointer /\*[a-z,A-Z,0-9]*++/
    highlight pointer ctermfg=darkblue
endfunction()


highlight LogError   ctermfg=darkred term=bold
highlight LogWarning ctermfg=yellow term=bold
highlight LogNotice  ctermfg=darkgreen term=bold
highlight LogDebug   ctermfg=blue
highlight LogTrace   ctermfg=grey

highlight LosFound    ctermfg=white   ctermbg=darkgreen
highlight LosNotFound ctermfg=black   ctermbg=yellow
highlight discoverOn ctermfg=magenta


function! s:pquevedo_AddLogHighlighting()
    " Logging Severity Level Highlighting
    "   Apply to any unknown filetype
    syntax match LogError /.*\[\v(ERROR|error)\].*/
    syntax match LogWarning /.*\[\v(WARN|WARNING|warn|warning)\].*/
    syntax match LogNotice /.*\[\v(NOTICE|notice)\].*/
    syntax match LogDebug /.*\[\v(DEBUG|DEBG|DBG|debug|dbg)\].*/
    syntax match LogTrace /.*\[\v(TRACE|trace)\].*/
    syntax match LosFound /.*LOS  Found.*/
    syntax match LosNotFound /.*LOS !Found.*/
    syntax match discoverOn /.*discoverEnb.*/
endfunction()

function! UpdateHighlighting() abort
    let l:ft = &filetype
    let c_types = ['c','h','cpp','hpp']
    let log_types = ['log','txt', '']
    if index(c_types, l:ft) >= 0 || index(log_types, l:ft) >= 0
        silent! TSDisable highlight
    else
        silent! TSEnable highlight
    endif

    if index(c_types, &l:ft) >= 0
        syntax on
        call s:pquevedo_AddCCodeHighlighting()
    elseif index(log_types, &l:ft) >= 0
        syntax off
        call s:pquevedo_AddLogHighlighting()
    else
        syntax on
    endif
endfunction

augroup CustomHighlighting
  autocmd!
  autocmd BufWinEnter,WinEnter * call UpdateHighlighting()
augroup END

