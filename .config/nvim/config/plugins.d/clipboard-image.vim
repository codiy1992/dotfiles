lua <<LUA
--
require'clipboard-image'.setup {
  -- Default configuration for all typefile
  default = {
    img_dir = "img",
    img_dir_txt = "img",
    img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
    affix = "![](/%s)",
    img_handler = function (img)
        local script = string.format('~/bin/imgup %s &', img.path)
        os.execute(script)
    end
  },
  -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
  -- If you're uncertain what to name your field to, you can run `:set filetype?`
  -- Missing options from `markdown` field will be replaced by options from `default` field
  markdown = {
    img_dir = "img",
    img_dir_txt = "img",
    affix = "![](/%s)"
  }
}

LUA
command! -nargs=* PasteImage call luaeval('
    \ require"clipboard-image.paste".paste_img({
        \ img_dir = "~/Assets/"..(_A[1] and _A[1] or os.date("/%Y/%m")),
        \ img_dir_txt = (_A[1] and _A[1] or os.date("/%Y/%m")),
        \ img_name = os.date("%d%H%M%S")..(_A[2] or "")
    \ })
    \ ', split('<args>'))

command! -nargs=* PasteImage2 call luaeval('
    \ require"clipboard-image.paste".paste_img({
        \ img_dir = "~/Assets/"..(_A[1] and _A[1] or os.date("/%Y/%m")),
        \ img_dir_txt = (_A[1] and _A[1] or os.date("/%Y/%m")),
        \ img_name = _A[2]
    \ })
    \ ', split('<args>'))

noremap <Leader>P :<C-U><C-R>="PasteImage "<CR>
