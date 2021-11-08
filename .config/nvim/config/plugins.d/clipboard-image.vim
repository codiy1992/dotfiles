lua <<EOF
require'clipboard-image'.setup {
  -- Default configuration for all typefile
  default = {
    img_dir = "./img",
    img_dir_txt = "./img",
    img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
    affix = "%s"
  },
  -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
  -- If you're uncertain what to name your field to, you can run `:set filetype?`
  -- Missing options from `markdown` field will be replaced by options from `default` field
  markdown = {
    img_dir = "./img",
    img_dir_txt = "./img",
    affix = "![](%s)"
  }
}
EOF

noremap <Leader>pp :<C-U><C-R>=printf("PasteImg %s", expand("img"))<CR>
