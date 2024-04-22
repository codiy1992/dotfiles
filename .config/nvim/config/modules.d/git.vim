" ---
" --- <airblade/vim-gitgutter>
" --- @link https://github.com/airblade/vim-gitgutter
" ---

" let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
" let g:gitgutter_sign_removed = '▏' or '▸'
let g:gitgutter_sign_removed = '▶'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'
highlight GitGutterAdd ctermfg=22 guifg=#A9DC76 ctermbg=NONE guibg=#242a32
highlight GitGutterChange ctermfg=58 guifg=#FC9867 ctermbg=NONE guibg=#242a32
highlight GitGutterDelete ctermfg=52 guifg=#FF6188 ctermbg=NONE guibg=#242a32
highlight GitGutterChangeDelete ctermfg=52 guifg=#FF6188 ctermbg=NONE guibg=#242a32


" ---
" --- <cohama/agit.vim>
" --- @link https://github.com/cohama/agit.vim
" ---
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1
