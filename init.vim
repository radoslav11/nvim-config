set termguicolors
let g:python_host_prog="/opt/homebrew/bin/python"
let g:python3_host_prog="/opt/homebrew/bin/python"
set shell=/bin/zsh

" Additional includes
let $CPLUS_INCLUDE_PATH .= ":" . expand("~/.config/nvim/langs_symlinks/cpp")

call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Plug 'ycm-core/YouCompleteMe', {'do': './install.py --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-commentary'
Plug 'vim-autoformat/vim-autoformat'

Plug 'kassio/neoterm'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

" Plug 'jiangmiao/auto-pairs'

Plug 'searleser97/cpbooster.vim'
Plug 'dmdque/solidity.vim'

Plug 'morhetz/gruvbox'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'sainnhe/gruvbox-material'

Plug 'tpope/vim-fugitive'

Plug 'rust-lang/rust.vim'
Plug 'czheo/mojo.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'madox2/vim-ai'

" Gromo
Plug 'yetone/avante.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

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

" morhetz/gruvbox
" Better visual mode selection for normal gruvbox
" let g:gruvbox_invert_selection=0
" let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox

" gruvbox-material is slightly nicer
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_diagnostic_text_highlight = 0
let g:gruvbox_material_diagnostic_line_highlight = 0
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
colorscheme gruvbox-material

" gruvbox.nvim works better with treesitter
" Other settings are in init.lua
" colorscheme gruvbox

" Don't save to register when "x" is pressed
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

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
" Still the same, but I now use the tmux plugin
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-H> <C-W><C-H>

tmap <C-ESC> <C-\><C-N>

autocmd FileType c,cpp,java,noir setlocal commentstring=//\ %s

" Spell check for some languages
autocmd BufEnter,BufNewFile *.{txt,md,html,tex} setlocal spell spelllang=en_us

nmap <C-/> :Commentary<CR>
imap <C-/> <ESC>:Commentary<CR>
vmap <C-/> :Commentary<CR>

imap <C-Enter> <ESC>:ToggleTerm<CR>
nmap <C-Enter> <ESC>:ToggleTerm<CR>
tmap <C-Enter> <C-\><C-N>:ToggleTerm<CR>

imap <C-`> <ESC>:NvimTreeToggle<CR>
nmap <C-`> <ESC>:NvimTreeToggle<CR>
tmap <C-`> <C-\><C-N>:NvimTreeToggle<CR>

autocmd FileType c       setlocal makeprg=gcc\ '%'\ -o\ '%:r'\ -std=gnu11
autocmd FileType cpp     setlocal makeprg=g++\ '%'\ -o\ '%:r'\ -std=c++17\ -O3\ -fsanitize=undefined,address
autocmd FileType haskell setlocal makeprg=ghc\ --make\ '%'
autocmd FileType java    setlocal makeprg=javac\ '%'
autocmd FileType tex     setlocal makeprg=xelatex\ -interaction\ nonstopmode\ -halt-on-error\ '%'

set clipboard=unnamedplus

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

" Folding
autocmd FileType python     set foldmethod=indent

" Formatting tab
set expandtab

let g:autoformat_autoindent = 0
let clang_format_style = "\'{
            \BasedOnStyle: Google,
            \TabWidth: 4,
            \IndentWidth: 4,
            \InsertBraces: true,
            \AccessModifierOffset: -2,
            \AlignAfterOpenBracket: BlockIndent,
            \AllowShortLoopsOnASingleLine: false,
            \SpaceBeforeParens: Never,
            \IncludeBlocks: Preserve,
            \SpaceBeforeCaseColon: false,
            \SpaceBeforeRangeBasedForLoopColon: false,
            \UseTab: Never,
            \PointerAlignment: Right,
            \ReferenceAlignment: Right,
            \DerivePointerAlignment: false,
            \SpaceAfterTemplateKeyword: false,
            \AlwaysBreakTemplateDeclarations: Yes
            \}'"

let g:formatdef_custom_clike = '"clang-format --style=' . clang_format_style . '"'
let g:formatters_java = ['custom_clike']
let g:formatters_cpp = ['custom_clike']
let g:formatters_cs = ['custom_clike']
let g:formatters_c = ['custom_clike']

let g:formatdef_custom_black = '"black -l 79 --preview -q ".(&textwidth ? "-l".&textwidth : "")." -"'
let g:formatters_python = ['custom_black']

nmap <Tab> :Autoformat<CR>

" Rust formatting using default formatter
autocmd FileType rust nmap <Tab> :RustFmt<CR>

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

set pumheight=12

inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Default coc.nvim code inspection settings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

let g:coc_snippet_next = "<c-k>"
let g:coc_snippet_prev = "<c-l>"

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

map <F3> <ESC>:CocRestart <CR>
imap <F3> <ESC>:CocRestart <CR>

" Autopairs stuff
let b:coc_pairs_disabled = ['<', '`']

" Disable Copilot for large files
autocmd BufReadPre *
            \ let f=getfsize(expand("<afile>"))
            \ | if f > 100000 || f == -2
            \ | let b:copilot_enabled = v:false
            \ | endif

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Disable auto commenting on new line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Cursor line
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

" Spellcheck
set spelllang=en_us
set spell

" Add lua specific settings
" They are available in lua/init.lua
lua require('init')
