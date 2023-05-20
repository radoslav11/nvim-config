set termguicolors

call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --all' }

Plug 'tpope/vim-commentary'
Plug 'vim-autoformat/vim-autoformat'

Plug 'kassio/neoterm'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'

Plug 'searleser97/cpbooster.vim'
Plug 'dmdque/solidity.vim'
Plug 'morhetz/gruvbox'
call plug#end()

set background=dark
syntax on
set mouse=a

set ts=4
set sts=4
set sw=4
set laststatus=2
set smartindent
set autoindent
set number
set smartcase
set whichwrap+=<,>,[,]

" Always put closing brackets
let g:AutoPairsFlyMode=0

let c_no_curly_error=1

" Better visual mode selection
let g:gruvbox_invert_selection=0
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" Iterm2 help is annoying
nmap <F1> <nop>
imap <F1> <nop>

" Find files using Telescope command-line sugar.
let mapleader = "\<Space>"
nnoremap <leader>ff :Telescope find_files<cr>
nnoremap <leader>mm :Telescope media_files<cr>
nnoremap <leader>fg :Telescope live_grep<cr>
nnoremap <leader>fb :Telescope buffers<cr>
nnoremap <leader>fh :Telescope help_tags<cr>

map <F2> <ESC>:w <CR>
imap <F2> <ESC>:w <CR>
map <C-T> :tabnew <CR>

nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>
imap <C-Left> <ESC>:tabprevious<CR>
imap <C-Right> <ESC>:tabnext<CR>

" Window bindings
nnoremap <C-L> <C-W><C-L>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>

tmap <C-ESC> <C-\><C-N>

autocmd FileType c,cpp,java setlocal commentstring=//\ %s
nmap <C-/> :Commentary<CR>
imap <C-/> <ESC>:Commentary<CR>
vmap <C-/> :Commentary<CR>

imap <C-Enter> <ESC>:ToggleTerm<CR>
nmap <C-Enter> <ESC>:ToggleTerm<CR>
tmap <C-Enter> <C-\><C-N>:ToggleTerm<CR>

imap <C-`> <ESC>:NvimTreeToggle<CR>
nmap <C-`> <ESC>:NvimTreeToggle<CR>
tmap <C-`> <C-\><C-N>:NvimTreeToggle<CR>

set clipboard=unnamed

autocmd FileType c       setlocal makeprg=gcc-13\ '%'\ -o\ '%:r'\ -std=gnu11
autocmd FileType cpp     setlocal makeprg=g++-13\ '%'\ -o\ '%:r'\ -std=c++17\ -O3
autocmd FileType haskell setlocal makeprg=ghc\ --make\ '%'
autocmd FileType java    setlocal makeprg=javac\ '%'
autocmd FileType tex     setlocal makeprg=xelatex\ -interaction\ nonstopmode\ -halt-on-error\ '%'

" Terminal commands
set splitright
command! -nargs=* VertTerm vsplit | te <args>

" From cuklev
autocmd QuickFixCmdPost [^l]* nested cwindow
function! ExecuteIfNoErrors()
	if len(getqflist()) == 0
		call ExecuteFile()
	endif
endfunction

function! ExecuteFile()
	if &filetype == "sh"
		write
		VertTerm bash "%"
	elseif &filetype == "java"
		write
		VertTerm java "%"
	elseif &filetype == "python"
		write
		VertTerm python3 "%"
	elseif &filetype == "javascript"
		write
		VertTerm node "%"
	elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell"
		VertTerm "%:p:r"
	elseif &filetype == "tex"
		" Make more general, so that it doesn't require MacOS
		:!open '%:r'.pdf
	elseif &filetype == "pdf" || &filetype == "png" || &filetype == "jpg" || &filetype == "jpeg"
		" Make more general, so that it doesn't require MacOS
		:!open "%"
	endif
endfunction

" Compile & Run
map <F9> <ESC>:w<CR>:make<CR>:call ExecuteIfNoErrors()<CR>
imap <F9> <ESC>:w<CR>:make<CR>:call ExecuteIfNoErrors()<CR>

map <F10> <ESC>:w<CR>:call ExecuteFile()<CR>
imap <F10> <ESC>:w<CR>:call ExecuteFile()<CR>

" Remap F9 for python
autocmd FileType python     map <F9> <ESC>:w<CR>:call ExecuteFile()<CR>
autocmd FileType python    imap <F9> <ESC>:w<CR>:call ExecuteFile()<CR>

" Formatting
autocmd FileType python        setlocal expandtab

let g:formatdef_custom_astyle = '"astyle --keep-one-line-blocks --style=google"'
let g:formatters_java = ['custom_astyle']
let g:formatters_cpp = ['custom_astyle']
let g:formatters_cs = ['custom_astyle']
let g:formatters_c = ['custom_astyle']

let g:formatdef_custom_black = '"black -l 79 --preview"'
let g:formatters_py = ['custom_black']

nmap <Tab> :Autoformat<CR>
nmap <F5> :CocDiagnostics<CR>

" It's annoying otherwise
source ~/.config/nvim/cyrilic.vim

" Hide default mode
set noshowmode

" Shift tab for code
vmap <Tab> >gv
vmap <S-tab> <gv

set backspace=2

" YCM actually works well
set completeopt-=preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'

" Add lua specific settings
" They are available in lua/init.lua
lua require('init')
