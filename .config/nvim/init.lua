-- Reference: https://github.com/nvim-lua/kickstart.nvim

require('general')
require('mappings')
require('autocmds')

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
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

  { -- Startify
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
      startify.section.top_buttons.val = {
      }
      startify.section.bottom_buttons.val = {
        startify.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
        startify.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
      }
    end,
  },
  {-- Color theme
    'sainnhe/everforest',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()

      vim.cmd.colorscheme('everforest')

      vim.g.everforest_background = 'hard'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_ui_contrast = 'high'


      -- vim.cmd.hi 'Comment gui=none'

      -- Windows Separator highlight Color
      -- vim.cmd [[
      --       highlight WinSeparator guifg=#7AA697
      --       highlight WinSeparator ctermfg=lightcyan
      -- ]]
      -- vim.wo.winhighlight = 'WinSeparator:WinSeparator'
    end,
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
  require 'plugins.misc',
  require 'plugins.tmux',
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

