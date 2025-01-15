return {
  { -- Quick jump with W
      -- https://github.com/smoka7/hop.nvim
    'smoka7/hop.nvim',
    version = "*",
    config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        vim.api.nvim_set_keymap('n', 'W', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
    end
  },

  { 'RaafatTurki/hex.nvim', opts = {} },

  { -- Align Code
    'junegunn/vim-easy-align',
    config = function()
        vim.api.nvim_set_keymap('x', '<Leader>a', '<Plug>(EasyAlign)', { noremap = false, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>a', '<Plug>(EasyAlign)', { noremap = false, silent = true })
    end
  },
}
