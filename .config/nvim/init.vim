" @link https://github.com/rosshadden/dotfiles
" @link https://github.com/scrapbird/dotfiles

runtime! config/general.vim

runtime! config/packages.vim

runtime! config/functions.vim config/mappings.vim

runtime! config/plugins.d/**/*.vim config/modules.d/**/*.vim

let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp $HOME/.config/nvim/templates/_machine_specific_default.vim $HOME/.config/nvim/_machine_specific.vim"
endif
runtime! _machine_specific.vim

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto Remove Trailing Whitespace on Save
autocmd BufWritePre * :%s/\s\+$//e

" ---
" --- Dress up my vim
" ---
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

color deus
hi NonText ctermfg=gray guifg=grey10

