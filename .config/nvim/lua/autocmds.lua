-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
  end,
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
