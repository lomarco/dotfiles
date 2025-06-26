local vim = vim or {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


------------ BASE SETTINGS
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.scrolloff = 4 -- 8
vim.opt.hlsearch = true
vim.opt.timeoutlen = 300
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append("sI")
vim.opt.fillchars = { eob = " " }
vim.opt.colorcolumn = "80"


------------ BASE KEYMAPS:
vim.g.mapleader = " "

-- Escape alias
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Auto brackets
vim.keymap.set('v', '<leader>"', 'c""<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', "<leader>'", "c''<Esc>P", { noremap = true, silent = true })
vim.keymap.set('v', '<leader>9', 'c()<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>{', 'c{}<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>[', 'c[]<Esc>P', { noremap = true, silent = true })

-- Buffers moving
vim.keymap.set('n', 'gn', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gp', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gw', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>be', ':enew<CR>', { noremap = true, silent = true })

-- Windows moving
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Fix terminal work (Off ESC and Shift-Space hot-keys)
vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set("t", "<S-Space>", "<Space>", { noremap = true, silent = true })


------------ PLULINS
require('lazy').setup({
  -- Prevelegios plugins
  {
    "lewis6991/impatient.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("impatient")
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
      vim.keymap.set('i', '<C-k>', 'copilot#Dismiss()', { expr = true, silent = true, noremap = true })
    end,
  },


  -- Menus
  {
    'nvim-tree/nvim-tree.lua',
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true }),
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
          side = 'left',
          preserve_window_proportions = true,
        },
        filters = {
          dotfiles = false,  -- showing dotfiles
          git_clean = false, -- showing gitignore files
        },
        git = {
          enable = true,  -- enable git status support
          ignore = false, -- not ignoring git files
        },
        renderer = {
          indent_markers = {
            enable = true, -- showing lines
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              none = " ",
            },
          },
          icons = {
            show = {
              file = false,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = true, -- close a tree when opening a file
            resize_window = true,
          },
        },
        update_focused_file = {
          enable = true,     -- follow the open file
          update_cwd = true, -- change work dir under the open file
        },
        diagnostics = {
          enable = true, -- showing errors/wanrs
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
      })
    end
  },
  {
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('barbar').setup({
        animation = false
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Live Grep' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end,    desc = 'Find Buffers' },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end,  desc = 'Help Tags' },
      { '<leader>fr', function() require('telescope.builtin').oldfiles() end,   desc = 'Recent Files' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })
    end
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Find TODOs' }
    }
  },
  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
    config = function()
      vim.g.tagbar_width = 50
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_sort = 0
      vim.g.tagbar_compact = 1
      vim.g.tagbar_autoclose = 0
      vim.keymap.set('n', '<leader>t', ':TagbarToggle<CR>', { desc = '[T]agbar [T]oggle' })
    end,
    keys = {
      { '<leader>t', ':TagbarToggle<CR>', desc = '[T]agbar [T]oggle' },
    }
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = { "<leader>h" },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>h]],
        direction = "horizontal",
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },


  -- Base text plugins
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "python", "lua", "asm", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<A-r>', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
      end

      local servers = { 'clangd', 'pyright', 'html', 'cssls', 'lua_ls', 'rust_analyzer' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
      end
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        sources = {
          { name = 'nvim_lsp', priority = 100 },
          { name = 'buffer',   priority = 10 },
          { name = 'path',     priority = 50 },
        },
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        max_item_count = 10,
      })
    end
  },


  -- Additional text plugins
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      char = { enabled = false },
      search = { enabled = false },
      treesitter = { enabled = false }
    },
    keys = {
      { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
    config = function(_, opts)
      require("flash").setup(opts)
      vim.keymap.del({ "n", "o", "x" }, "f")
      vim.keymap.del({ "n", "o", "x" }, "F")
      vim.keymap.del({ "n", "o", "x" }, "t")
      vim.keymap.del({ "n", "o", "x" }, "T")
      vim.keymap.del({ "n", "o", "x" }, ";")
      vim.keymap.del({ "n", "o", "x" }, ",")
    end,
  },
  ---------------- For vim moving ----------------
  {
    "matze/vim-move",
    keys = {
      { "<A-j>", mode = { "n", "v" } },
      { "<A-k>", mode = { "n", "v" } },
    },
    config = function()
    end,
  },


  -- Git
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)
        end
      })
    end
  },


  -- Themes
  {
    'rafi/awesome-vim-colorschemes',
    config = function()
      vim.cmd.colorscheme('purify')
      -- purify,vscode,molokai,one,elflord,desert,yellow-moon,challenger_deep,industry,gruvbox,retrobox,nord,onedark,pablo,darkblue,blue,PaperColor
      vim.opt.background = 'dark'

      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  },
  {
    "mofiqul/vscode.nvim",
    lazy = true,
    config = function()
    end
  },
})


------------ CUSTOM:
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'asm',
  callback = function()
    vim.keymap.set('n', '<C-b>', ':!fasm %CR>',
      { noremap = true, silent = true })
    vim.keymap.set('n', '<C-r>', ':!./%:r<CR>', { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c,h,ino',
  callback = function()
    -- vim.keymap.set('n', '<c-b>', ':!make && make clean:r<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<c-b>', ':!clang % && ./a.out<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<a-f>', ':!clang-format --style chromium -i %<cr>', { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp,cxx',
  callback = function()
    vim.keymap.set('n', '<c-b>', ':!clang++ % && ./a.out<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<a-f>', ':!clang-format --style chromium -i %<cr>', { noremap = true, silent = true })
  end,
})
