" ---
" --- <RRethy/vim-illuminate>
" --- @link https://github.com/RRethy/vim-illuminate
" --- Highlight Words Under Cursor
" ---
let g:Illuminate_delay = 100
highlight illuminatedWord cterm=underline guibg=NULL guifg=#11bbcc


" ---
" --- <luochen1990/rainbow>
" --- @link https://github.com/luochen1990/rainbow
" ---
let g:rainbow_active = 1






" ---
" --- <windwp/nvim-autopairs>
" --- @link https://github.com/windwp/nvim-autopairs
" ---
lua <<LUA
require('nvim-autopairs').setup{}
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false,  -- auto select first item
})
LUA




" ---
" --- <hrsh7th/nvim-compe>
" --- @link https://github.com/hrsh7th/nvim-compe
" ---
lua <<LUA
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
    tabnine = true;
    tmux = true;
  };
}
LUA



inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })




" ---
" --- <phaazon/hop.nvim>
" --- @link https://github.com/phaazon/hop.nvim
" ---
lua <<LUA
require'hop'.setup()
vim.api.nvim_set_keymap("n", "C", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
LUA

