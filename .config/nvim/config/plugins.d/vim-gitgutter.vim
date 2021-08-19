" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
" let g:gitgutter_sign_removed = '▏' or '▸'
let g:gitgutter_sign_removed = '▶'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'
" let g:gitgutter_override_sign_column_highlight = 1

" let g:gitgutter_sign_column_always = 1

highlight GitGutterAdd ctermfg=22 guifg=#A9DC76 ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermfg=58 guifg=#FC9867 ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermfg=52 guifg=#FF6188 ctermbg=NONE guibg=NONE
highlight GitGutterChangeDelete ctermfg=52 guifg=#FF6188 ctermbg=NONE guibg=NONE
