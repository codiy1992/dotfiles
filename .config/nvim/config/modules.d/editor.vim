" ---
" --- <RRethy/vim-illuminate>
" --- @link https://github.com/RRethy/vim-illuminate
" --- Highlight Words Under Cursor
" ---
hi def illuminatedWordText cterm=underline guibg=NULL guifg=#11bbcc
hi def illuminatedWordRead cterm=underline guibg=NULL guifg=#11bbcc
hi def illuminatedWordWrite cterm=underline guibg=NULL guifg=#11bbcc

lua <<EOF
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    delay = 100,
    filetype_overrides = {},
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = nil,
    large_file_overrides = nil,
})
EOF

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
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
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
vim.api.nvim_set_keymap('n', '<M-space>', "<cmd>lua require'hop'.hint_char1()<cr>", { silent = true })
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



" ---
" --- <prettier/vim-prettier>
" --- @link https://github.com/prettier/vim-prettier
" ---
let g:prettier#config#use_tabs = 'false'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml PrettierAsync

