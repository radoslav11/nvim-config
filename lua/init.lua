vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.fillchars = { eob = " "}

require("toggleterm").setup()
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 34,
    },
    renderer = {
        group_empty = true,
    },
})
require("telescope").setup({
    extensions = {
        media_files = {
            find_cmd = "rg"
        }
    },
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                preview_height = 0.5,
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
    },
})

require("telescope").load_extension("media_files")
require('lualine').setup({
    options = {
        theme = 'gruvbox-material',
        icons_enabled = true,
        section_separators = {left='', right=''},
        component_separators = {left='', right=''},
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})
require("bufferline").setup()
require"nvim-treesitter.configs".setup{
    ensure_installed = {
        "c", "cpp", "python", "lua", "typescript", "javascript", "vim", "vimdoc", "query", "haskell", "cuda", "bash", "java"
    },
    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        additional_vim_regex_highlighting = false,
    },
}
require("treesitter-context").setup()
