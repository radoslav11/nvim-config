" Inverse Scrolling
noremap <ScrollWheelDown> <ScrollWheelUp>
noremap <ScrollWheelUp> <ScrollWheelDown>
inoremap <ScrollWheelDown> <ScrollWheelUp>
inoremap <ScrollWheelUp> <ScrollWheelDown>
vnoremap <ScrollWheelDown> <ScrollWheelUp>
vnoremap <ScrollWheelUp> <ScrollWheelDown>

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont JetBrainsMono Nerd Font:h12
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

cd ~
