-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<Leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '✚',
          deleted = '✖',
          modified = '',
          renamed = '󰁕',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
    filesystem = {
      follow_current_file = { enable = true },
      group_empty_dirs = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = {
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
      },
    },
    window = {
      width = 30,
      mappings = {
        ['/'] = '',
        ['<Leader>e'] = 'close_window',
        ['h'] = 'close_node',
        ['l'] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require('neo-tree.sources.filesystem').toggle_directory(state, node)
            elseif node:has_children() then
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          else
            state.commands['focus_preview'](state)
          end
        end,
      },
    },
  },
}
