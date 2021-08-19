" ---
" ---  Auto load for first time uses
" ---

if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ---
" --- Install Plugins with Vim-Plug
" ---

call plug#begin('$HOME/.config/nvim/plugged')

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" Pretty Dress
Plug 'theniceboy/nvim-deus'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" General Highlighter
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'kevinhwang91/rnvimr'
Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'

" Taglist
Plug 'liuchengxu/vista.vim'

" Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-go'}

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'

" Snippets
" Plug 'theniceboy/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-fugitive'

" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
" Plug 'elzr/vim-json'
" Plug 'neoclide/jsonc.vim'
" Plug 'othree/html5.vim'
" Plug 'alvan/vim-closetag'
" Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'pantharshit00/vim-prisma'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'        " comment and un comment code by type <leader>cc, <leader>cu
Plug 'tpope/vim-surround'             " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim'              " in Visual mode, press <Enter> to Select Text
Plug 'junegunn/vim-after-object'      " da= to delete what's after =
" Plug 'easymotion/vim-easymotion'
Plug 'rhysd/clever-f.vim'             " extends f, F, t and T mappings for more convenience
Plug 'Yggdroot/indentLine'            " Add indentline every 4 spaces
Plug 'junegunn/vim-easy-align'        " Align code by type <leader>a=, <leader>a: etc.
Plug 'christoomey/vim-tmux-navigator' " Move cursor between vim and tmux
" Mini Vim-APP
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/asyncrun.vim'
" let g:asyncrun_open = 6
" noremap gp :AsyncRun git push<CR>

" Other visual enhancement
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'

" Other useful utilities
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite

call plug#end()
