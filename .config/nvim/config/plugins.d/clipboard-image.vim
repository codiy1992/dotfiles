lua <<LUA
require'clipboard-image'.setup {
  -- Default configuration for all typefile
  default = {
    img_dir = "img",
    img_dir_txt = "img",
    img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
    affix = "%s"
  },
  -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
  -- If you're uncertain what to name your field to, you can run `:set filetype?`
  -- Missing options from `markdown` field will be replaced by options from `default` field
  markdown = {
    img_dir = "img",
    img_dir_txt = "img",
    affix = "![](https://static.codiy.net%s)"
  }
}
LUA

command! -nargs=* PasteImage call luaeval('require"clipboard-image.paste".paste_img({
                \ img_dir = _A[1], img_dir_txt = _A[2], img_name = _A[3]
                \ })', split('<args>'))
noremap <Leader>pp :<C-U><C-R>=printf("PasteImage %s", expand(""))<CR>

