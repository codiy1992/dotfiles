-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


-- Command Mode Cursor Movement
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', { noremap = true })
-- Other useful stuff
vim.api.nvim_set_keymap('n', '<LEADER>Q', ':qa!<CR>', { noremap = true })
-- Auto change directory to current dir
-- vim.api.nvim_exec([[autocmd BufEnter * silent! lcd %:p:h]], false)

-- find and replace
vim.api.nvim_set_keymap('n', '\\s', ':s//g<left><left>', { noremap = true })
vim.api.nvim_set_keymap('n', '\\S', ':%s//g<left><left>', { noremap = true })



-------------
-- Windows
-------------
vim.api.nvim_set_keymap('n', 's', '<nop>', { noremap = true })

-- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
vim.api.nvim_set_keymap('n', 'sk', ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sj', ':set splitbelow<CR>:split<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sh', ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sl', ':set splitright<CR>:vsplit<CR>', { noremap = true })

-- Resize splits with arrow keys (iterm2 need set left Option key to Esc+)
vim.api.nvim_set_keymap('n', '<A-k>', ':res +5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-j>', ':res -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-h>', ':vertical resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':vertical resize +5<CR>', { noremap = true })

-- Place the two screens up and down
vim.api.nvim_set_keymap('n', 'st', '<C-w>t<C-w>K', { noremap = true })
-- Place the two screens side by side
vim.api.nvim_set_keymap('n', 'sv', '<C-w>t<C-w>H', { noremap = true })

-- Rotate screens
vim.api.nvim_set_keymap('n', 'srh', '<C-w>b<C-w>K', { noremap = true })
vim.api.nvim_set_keymap('n', 'srv', '<C-w>b<C-w>H', { noremap = true })

-- Press <SPACE> + qq to close current window
vim.api.nvim_set_keymap('n', '<LEADER>qq', '<C-w>:q!<CR>', { noremap = true })



-------------
-- Tabs
-------------
vim.api.nvim_set_keymap('n', 'th', ':tabfirst<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tl', ':tablast<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tt', ':tabedit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tn', ':tabnext<Space>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tm', ':tabm<Space>', { noremap = true })
vim.api.nvim_set_keymap('n', 'td', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>1', '1gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>2', '2gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>3', '3gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>4', '4gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>5', '5gt', { noremap = true })
