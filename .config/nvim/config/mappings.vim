" ---
" --- Basic Mappings
" ---
" Set <LEADER> as <SPACE>
let mapleader=" "

" Open the vimrc file anytime
noremap <LEADER>rc :e $HOME/.config/nvim/init.vim<CR>

noremap <silent> zk 5k
noremap <silent> zj 5j
noremap W 5w
noremap B 5b
noremap <silent> - $
" Source Configuration
nnoremap <Leader>rr :source $MYVIMRC<CR>

" ---
" --- Command Mode Cursor Movement
" ---
cnoremap <C-a> <Home>

" ---
" --- Window management
" ---
" <C-w>w
" <C-w>k
" <C-w>j
" <C-w>h
" <C-w>l
" <C-w>o
" <C-w>q

" Disable the default s key, 's' is short for 'cl'
noremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap st <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q!<CR>


" ---
" --- Tab management
" ---
" Create a new tab with tu
noremap tk :tabe<CR>
noremap tK :tab split<CR>
" Move around tabs with th and tl
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmh and tml
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>

" ---
" --- Other useful stuff
" ---

" Open a new instance of st with the cwd
nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
" find and replace
noremap \s :%s//g<left><left>
" you know
noremap <silent> \v v$h
" set wrap
noremap <LEADER>sw :set wrap<CR>
noremap <LEADER>snw :set nowrap<CR>
