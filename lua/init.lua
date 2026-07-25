vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.fillchars = { eob = " "}
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3
vim.g.maplocalleader = '  '

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

require("lualine").setup({
    options = {
        theme = "gruvbox-material",
        icons_enabled = true,
        section_separators = {left="", right=""},
        component_separators = {left="", right=""},
        -- component_separators = { left = "", right = ""},
        -- section_separators = { left = "", right = ""},
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
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {"filename"},
        lualine_x = {"encoding", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

require("bufferline").setup()

-- nvim-treesitter's main branch uses Neovim's native highlighting API. The
-- former `nvim-treesitter.configs` module belongs to the frozen master branch
-- and is incompatible with Neovim 0.12.
require("nvim-treesitter").setup({
    -- Put parsers compiled by the main branch before the legacy parser
    -- binaries retained inside Vim-Plug's plugin checkout.
    install_dir = vim.fn.stdpath("data") .. "/site",
})

local treesitter_filetypes = {
    "bash",
    "c",
    "cpp",
    "css",
    "cuda",
    "haskell",
    "html",
    "java",
    "javascript",
    "lua",
    "markdown",
    "python",
    "query",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitter_filetypes,
    callback = function(event)
        -- Preserve the old 100 KiB cutoff for Tree-sitter highlighting.
        local max_filesize = 100 * 1024
        local ok, stats = pcall(
            vim.uv.fs_stat,
            vim.api.nvim_buf_get_name(event.buf)
        )
        if ok and stats and stats.size > max_filesize then
            return
        end

        -- A missing optional parser should not prevent the buffer from opening.
        pcall(vim.treesitter.start, event.buf)
    end,
})

require("cmp").setup({})
require("treesitter-context").setup({})
require("render-markdown").setup({})

-- require("avante").setup({
--   -- provider = "claude",
--   provider = "openai",
--   -- mode = "legacy",
--   mode = "agentic",

--   -- provider = "deepseek",
--   -- vendors = {
--   --   deepseek = {
--   --     __inherited_from = "openai",
--   --     api_key_name = "",
--   --     endpoint = "http://127.0.0.1:1234/v1",
--   --     model = "deepseek-coder-v2-lite-instruct-mlx",
--   --   },
--   -- },

--   providers = {
--       claude = {
--         endpoint = "https://api.anthropic.com",
--         -- Rate limits are not great.
--         -- model = "claude-sonnet-4-20250514",
--         model = "claude-3-7-sonnet-20250219",
--         -- model = "claude-3-5-sonnet-latest",
--         -- disable_tools = true,

--         extra_request_body = {
--             temperature = 0,
--             max_tokens = 8192,
--         }
--       },
--   },

--   mappings = {
--     behaviour = {
--         -- auto_suggestions = true,
--         auto_suggestions = false,
--         auto_set_highlight_group = true,
--         auto_set_keymaps = true,
--         auto_apply_diff_after_generation = false,
--         support_paste_from_clipboard = false,
--     },
--   },
--   selection = {
--     enabled = false,
--   },
--   windows = {
--     wrap = true, -- similar to vim.o.wrap
--     width = 30, -- default % based on available width
--     sidebar_header = {
--       align = "center", -- left, center, right for title
--       rounded = false,
--     },
--   },
--   highlights = {
--     diff = {
--       current = "DiffText",
--       incoming = "DiffAdd",
--     },
--   },
--   diff = {
--     debug = false,
--     autojump = true,
--     list_opener = "copen",
--   },
-- })

vim.g.lean_config = { mappings = true }
