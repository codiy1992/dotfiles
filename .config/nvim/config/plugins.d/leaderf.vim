let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0, 'Rg': 1 }

let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 0
let g:Lf_UseCache = 0
let g:Lf_UseMemoryCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" let g:Lf_WorkingDirectory = finddir('.git', '.;')
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_RootMarkers = ['dockers', '.git']
let g:Lf_CommandMap = {
          \ '<C-]>': ['<C-I>'],
          \ '<C-X>': ['<C-B>'],
          \}

let g:Lf_WildIgnore = {
        \ 'dir': [
            \'.git', 'vendor', 'node_modules', 'plugged', 'elpa', 'cache', 'undo',
            \'.cache', '.oh-my-zsh', '.npm', '.vscode',
            \'Library', 'Applications', 'Documents', 'Downloads', 'Movies', 'Music', 'Pictures'],
        \ 'file': [
            \'*.css', '*.png', '*.jpg', '*.pdf', '*.gif', '*.mp4',
            \'*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]',
            \'__vim_project_root', 'class', '.DS_Store']
        \}
let g:Lf_ShortcutF = '<Leader>ff'
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" rg
" \ "--glob=*.{php,go,vim,js,md,py}",
let g:Lf_RgConfig = [
        \ "--max-columns=150",
        \ "--max-columns-preview",
        \ "--smart-case",
        \ "--hidden"
    \ ]

" search word under cursor literally in all listed buffers
noremap <Leader><C-B> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>
noremap <Leader><C-C> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <Leader><C-F> :<C-U><C-R>=printf("Leaderf! rg %s -e \"\"", expand(getcwd()))<CR>
" search visually selected text literally
xnoremap <leader>gf :<C-U><C-R>=printf("Leaderf! rg -e %s ", leaderf#Rg#visual())<CR>
noremap <Leader>go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

