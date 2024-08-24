# nvim-config
Neovim config requires Plug (and maybe copilot). You should clone this repo
into `~/.config/nvim`, or the configuration directory for your nvim. Some of the plugins
do have additional dependencies, like `fzf`, `clang-format` and `black`. Also, if you want a JetBarains-like
file search, you should install `ripgrep`.

# Installation
For those unfamiliar with Plug, you simply need to `:PlugInstall`. If you don't want some
of the plugins, simply comment them out from `init.vim`.

# Fonts
Some of the plugins require a [Nerd Font](https://www.nerdfonts.com/font-downloads).  I recommend
the Regular JetBrains Nerd font.

# Key Bindings
The additional key bindings are quite standard:
- Moving between splits with `<C-h>`, `<C-j>`, `<C-k>` and `<C-l>`. For those unfamiliar with
splits, for horrizonal splitting you can do `<C-w>n`, while for vertical you can do `<C-w>v`.
- Toggle terminal with `<C-Enter>`. Note that terminal mode can be both insert and normal. To
ensure that the standard terminal key bindings work (like `<C-l>` for clear), we use `<C-ESC>`
to go into normal mode.
- `<TAB>` in normal mode formats the file (C/C++/Java with astyle, Python with black).
- For browsing files, toggle nvim-tree using `` C-` ``.
- There are a few search file funcionalities that are available through Telescope. The 
keybindings use the `<leader>` which I've set up as `<SPACE>`. For example, `<leader>ff` searches
for files based on name. For the JetBrains-like search, I use `<leader>fg` which runs `ripgrep`. 
Check `init.vim` for more details.

# (Optional) Copilot
Follow the installation on https://github.com/github/copilot.vim, and add it ot `pack/`.
You will be prompted to login from a browser, or put a 6 digit code.

# Dependencies

Nowadays, the ones that I use are:
- `ripgrep` and `fzf` for search.
- `clang-format` for formatting C/C++/C#/Java.
- `black` for formatting python.
