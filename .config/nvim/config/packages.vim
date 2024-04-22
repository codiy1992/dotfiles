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
" treesitter
" Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Color Theme
Plug 'ajmwagar/vim-deus'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File navigation
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Taglist
Plug 'liuchengxu/vista.vim'

" Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-go'}


" LSP, Completion, Diagnostic, Linter, Formater, Debugger, Snippets etc.
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/compe-tmux', { 'branch': 'compe' }
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'tpope/vim-fugitive'

" CSS
Plug 'ap/vim-css-color'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' , 'do': 'go install golang.org/x/tools/gopls@latest'}

" Markdown
Plug 'codiy1992/clipboard-image.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Editor Enhancement
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-surround'             " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim'              " in Visual mode, press <Enter> to Select Text
Plug 'phaazon/hop.nvim'               " easy motion
Plug 'rhysd/clever-f.vim'             " extends f, F, t and T mappings for more convenience
Plug 'Yggdroot/indentLine'            " Add indentline every 4 spaces
Plug 'junegunn/vim-easy-align'        " Align code by type <leader>a=, <leader>a: etc.
Plug 'christoomey/vim-tmux-navigator' " Move cursor between vim and tmux
Plug 'rrethy/vim-illuminate'          " Highlight Words Under Cursor
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'machakann/vim-highlightedyank'
call plug#end()
