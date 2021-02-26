" ==== Neovim settings for vscode integration ====
"
" Contains rough equivilants to what my neovim setup does for the same
" keystrokes

let mapleader=","
nnoremap <Leader>f :Ex<CR>
nnoremap <Leader>s <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
nnoremap <Leader>h <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>

nnoremap <Leader>r <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap <Leader>a <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
