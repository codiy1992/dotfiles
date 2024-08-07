" @link https://github.com/rosshadden/dotfiles
" @link https://github.com/scrapbird/dotfiles

runtime! config/general.vim

runtime! config/packages.vim

" ---
" --- Dress up my vim
" ---
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark    " Setting dark mode

color deus

set listchars=tab:→\ ,trail:·
" used for `eol`, `extends` and `precedes`
hi NonText ctermfg=gray guifg=grey30
" for `nbsp`, `space`, `tab` and `trail`
hi Whitespace ctermfg=gray guifg=grey30

let g:python3_host_prog='/usr/bin/python3'

runtime! config/functions.vim config/mappings.vim

runtime! config/plugins.d/**/*.vim config/modules.d/**/*.vim


au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto Remove Trailing Whitespace on Save
autocmd BufWritePre *[^{.md}] :%s/\s\+$//e

command! -nargs=? Epu :enew|pu=execute('<args>')
