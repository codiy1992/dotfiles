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

-------------------------------------- codiy

vim.api.nvim_set_keymap('n', '<LEADER>rc', ':e $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>rr', ':source $MYVIMRC<CR>', { noremap = true })

-- --- 命令模式光标移动
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', { noremap = true })

-- --- 其他有用的功能
vim.api.nvim_set_keymap('n', '<LEADER>Q', ':qa!<CR>', { noremap = true })

-- 在普通模式下按 Esc 清除高亮
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<return><esc>', { noremap = true })

-- 在新标签页中打开一个新的 st 实例
vim.api.nvim_set_keymap('n', '\t', ':tabe<CR>:-tabmove<CR>:term sh -c \'st\'<CR><C-\\><C-N>:q<CR>', { noremap = true })

-- 自动更改当前目录到当前文件目录（如果需要，可以取消注释）
-- vim.api.nvim_exec([[autocmd BufEnter * silent! lcd %:p:h]], false)

-- 查找和替换
vim.api.nvim_set_keymap('n', '\\s', ':s//g<left><left>', { noremap = true })
vim.api.nvim_set_keymap('n', '\\S', ':%s//g<left><left>', { noremap = true })

-- 你知道的
vim.api.nvim_set_keymap('n', '<silent>', '\\v v$h', { noremap = true })

-- 设置换行
vim.api.nvim_set_keymap('n', '<LEADER>sw', ':set wrap<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<LEADER>snw', ':set nowrap<CR>', { noremap = true })



-- Windows
--
-- 禁用 s 键的映射
vim.api.nvim_set_keymap('n', 's', '<nop>', { noremap = true })

-- 将屏幕分割为上下和左右
vim.api.nvim_set_keymap('n', 'sk', ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sj', ':set splitbelow<CR>:split<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sh', ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'sl', ':set splitright<CR>:vsplit<CR>', { noremap = true })

-- 使用箭头键调整分割窗口大小（在 iTerm2 中需要将左 Option 键设置为 Esc+）
vim.api.nvim_set_keymap('n', '<A-k>', ':res +5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-j>', ':res -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-h>', ':vertical resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':vertical resize +5<CR>', { noremap = true })

-- 将两个屏幕上下放置
vim.api.nvim_set_keymap('n', 'st', '<C-w>t<C-w>K', { noremap = true })
-- 将两个屏幕并排放置
vim.api.nvim_set_keymap('n', 'sv', '<C-w>t<C-w>H', { noremap = true })

-- 旋转屏幕
vim.api.nvim_set_keymap('n', 'srh', '<C-w>b<C-w>K', { noremap = true })
vim.api.nvim_set_keymap('n', 'srv', '<C-w>b<C-w>H', { noremap = true })

-- 按 <SPACE> + q 关闭当前窗口下方的窗口
vim.api.nvim_set_keymap('n', '<LEADER>q', '<C-w>j:q!<CR>', { noremap = true })



-- Tabs
-- 标签页导航映射
vim.api.nvim_set_keymap('n', 'th', ':tabfirst<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tl', ':tablast<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tt', ':tabedit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tn', ':tabnext<Space>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tm', ':tabm<Space>', { noremap = true })
vim.api.nvim_set_keymap('n', 'td', ':tabclose<CR>', { noremap = true })

-- 使用 <leader> 进行标签页切换
vim.api.nvim_set_keymap('n', '<leader>1', '1gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>2', '2gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>3', '3gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>4', '4gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>5', '5gt', { noremap = true })
