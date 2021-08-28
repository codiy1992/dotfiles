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
require('nvim-autopairs').remove_rule('(')-- remove rule (
LUA


" ---
" --- <hrsh7th/nvim-cmp>
" --- @link https://github.com/hrsh7th/nvim-cmp
" ---
lua <<EOF
  local cmp = require('cmp')
  cmp.setup {
    -- You can set mappings if you want
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm()
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = 'cmp_tabnine' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'tmux' },
      { name = 'path' },
    },
  }
EOF


" ---
" --- <phaazon/hop.nvim>
" --- @link https://github.com/phaazon/hop.nvim
" ---
lua <<LUA
require'hop'.setup()
vim.api.nvim_set_keymap('n', 'w', "<cmd>lua require'hop'.hint_char1()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', 'W', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', 'L', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', 'P', "<cmd>lua require'hop'.hint_patterns()<cr>", { silent = true })
LUA




" ---
" --- <mhinz/vim-startify>
" --- @link https://github.com/mhinz/vim-startify
" ---
let g:startify_enable_special = 0
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_custom_header = []
let g:startify_bookmarks = [
            \ { 'a': '~/Works' },
            \ { 'b': '~/Repos' },
            \ { 'c': '~/.config/nvim' },
            \ ]
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ ]
