-- Reference: https://github.com/nvim-lua/kickstart.nvim

require('general')
require('mappings')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {
    'luochen1990/rainbow',
    config = function()
        vim.g.rainbow_active = 1
    end
  },

  {
      -- https://github.com/smoka7/hop.nvim
    'smoka7/hop.nvim',
    version = "*",
    config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        vim.api.nvim_set_keymap('n', 'W', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
    end
  },
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },
  { 'RaafatTurki/hex.nvim', opts = {} },
  {
    'junegunn/vim-easy-align', -- https://github.com/junegunn/vim-easy-align
    config = function()
        vim.api.nvim_set_keymap('x', '<Leader>a', '<Plug>(EasyAlign)', { noremap = false, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>a', '<Plug>(EasyAlign)', { noremap = false, silent = true })
    end
  },
  require 'plugins.which_key',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.auto_format',
  require 'plugins.auto_completion',
  require 'plugins.enhancement',
  require 'plugins.debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.auto_pairs',
  require 'plugins.neo_tree',
  require 'plugins.git_signs',
  require 'plugins.theme',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- When open file Auto Jump to last edit position
vim.api.nvim_create_augroup('JumpToLastEdit', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'JumpToLastEdit',
    pattern = '*',
    callback = function()
        local last_line = vim.fn.line("'\"")
        local current_line = vim.fn.line("$")
        if last_line > 1 and last_line <= current_line then
            vim.cmd('normal! g\'\"')
        end
    end,
})

-- Auto Remove Trailing Whitespace on Save
vim.api.nvim_create_augroup('TrimTrailingWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'TrimTrailingWhitespace',
    pattern = '*',
    callback = function()
        if vim.fn.expand('%:e') ~= 'md' then
            vim.cmd('%s/\\s\\+$//e')
        end
    end,
})
