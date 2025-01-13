" <C-w>w
" <C-w>k
" <C-w>j
" <C-w>h
" <C-w>l
" <C-w>o
" <C-w>q

" Disable the default s key, 's' is short for 'cl'
if !exists('g:vscode') " Compatible with VSCode
    noremap s <nop>
    " split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
    noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
    noremap sj :set splitbelow<CR>:split<CR>
    noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
    noremap sl :set splitright<CR>:vsplit<CR>
    " Resize splits with arrow keys (iterm2 need set left Option key to Esc+)
    noremap <A-k> :res +5<CR>
    noremap <A-j> :res -5<CR>
    noremap <A-h> :vertical resize-5<CR>
    noremap <A-l> :vertical resize+5<CR>

    " Place the two screens up and down
    noremap st <C-w>t<C-w>K
    " Place the two screens side by side
    noremap sv <C-w>t<C-w>H

    " Rotate screens
    noremap srh <C-w>b<C-w>K
    noremap srv <C-w>b<C-w>H

    " Press <SPACE> + q to close the window below the current window
    noremap <LEADER>q <C-w>j:q!<CR>
endif
