" lua <<LUA
" require('nvim-treesitter.configs').setup {
  " ensure_installed = {
    " 'bash',
    " 'c',
    " 'c_sharp',
    " 'clojure',
    " 'cpp',
    " 'dockerfile',
    " 'gdscript',
    " 'go',
    " 'html',
    " 'javascript',
    " 'json',
    " 'lua',
    " 'php',
    " 'python',
    " 'toml',
    " 'tsx',
    " 'typescript',
    " 'yaml',
  " },
  " highlight = { enable = true },
  " incremental_selection = { enable = true },
  " textobjects = { enable = true },
" }
" LUA


autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
