" ---
" --- Basic Mappings
" ---
" Set <LEADER> as <SPACE>
let mapleader=" "

" Open the vimrc file anytime
noremap <LEADER>rc :e $MYVIMRC<CR>
" Source Configuration
nnoremap <Leader>rr :source $MYVIMRC<CR>

noremap <LEADER>w <ESC>:w <CR>

" Cursor Movement
noremap <silent> - $

" ---
" --- Command Mode Cursor Movement
" ---
cnoremap <C-a> <Home>

" ---
" --- Other useful stuff
" ---

noremap <LEADER>Q :qa!<CR>
" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
" Open a new instance of st with the cwd
nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
" Auto change directory to current dir
" autocmd BufEnter * silent! lcd %:p:h
" find and replace
noremap \s :s//g<left><left>
noremap \S :%s//g<left><left>
" you know
noremap <silent> \v v$h
" set wrap
noremap <LEADER>sw :set wrap<CR>
noremap <LEADER>snw :set nowrap<CR>
