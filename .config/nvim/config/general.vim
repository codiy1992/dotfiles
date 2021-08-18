" ---
" --- System
" ---
let &t_ut=''
set autochdir

" ---
" --- Editor behavior
" ---
set exrc
set secure
set nonumber
set relativenumber
set signcolumn=auto             " 是否显示标志列
set cursorline
set hidden
set softtabstop=2
set tabstop=4                   " 一个 tab 显示出来是多少个空格，默认 8
set expandtab ts=4 sw=4 ai      " 设置一个tab为4个空格
set shiftwidth=4                " 每一级缩进是多少个空格
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent           " 代码折叠方式
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set colorcolumn=100
set updatetime=100
set virtualedit=block
" --- vim cliboards: unamed, *, +
" see https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
" see https://unix.stackexchange.com/questions/139578/copy-paste-for-vim-is-not-working-when-mouse-set-mouse-a-is-on
set clipboard=unnamed
set mouse+=a "Tips: Press `shift` or `alt/option`(OSX) while selecting

" directories
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/swap
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/swap,.
if has('persistent_undo')
	set undofile
    silent !mkdir -p $HOME/.config/nvim/tmp/undo
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif

" Use new regular expression engine
set re=0

" experimental
set lazyredraw
"set regexpengine=1
