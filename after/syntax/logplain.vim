" Highlight rules
syntax match LogError      /.*\[\v(ERROR|error)\].*/
syntax match LogWarning    /.*\[\v(WARN|WARNING|warn|warning)\].*/
syntax match LogNotice     /.*\[\v(NOTICE|notice)\].*/
syntax match LogDebug      /.*\[\v(DEBUG|DEBG|DBG|debug|dbg)\].*/
syntax match LogTrace      /.*\[\v(TRACE|trace)\].*/
syntax match LosFound      /.*LOS  Found.*/
syntax match LosNotFound   /.*LOS !Found.*/
syntax match discoverOn    /.*discoverEnb.*/

syntax match LogError /.*- ERROR -.*/
syntax match LogWarning /.*- WARNING -.*/
syntax match LogNotice /.*- NOTICE -.*/
syntax match LogDebug /.*- DEBUG -.*/

" Highlight definitions for both 24bit and 256-color palettes
highlight LogError      guifg=#ff5555 ctermfg=DarkRed  gui=bold  cterm=bold
highlight LogWarning    guifg=#ffd700 ctermfg=Yellow   gui=bold  cterm=bold
highlight LogNotice     guifg=#88ff88 ctermfg=DarkGreen gui=bold cterm=bold
highlight LogDebug      guifg=#8fb3ff ctermfg=Blue
highlight LogTrace      guifg=#a0a0a0 ctermfg=Grey
highlight LosFound      guifg=#ffffff guibg=#006400  ctermfg=White ctermbg=DarkGreen
highlight LosNotFound   guifg=#000000 guibg=#ffd700  ctermfg=Black ctermbg=Yellow
highlight discoverOn    guifg=#ff66cc ctermfg=Magenta
