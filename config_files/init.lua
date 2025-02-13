vim = vim or {}

-- Automatic installation of lazy.nvim if it is missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------ ALL SETTINGS
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = false
vim.opt.scrolloff = 8
vim.opt.hlsearch = true
vim.opt.colorcolumn = "100"
vim.opt.fillchars = { eob = " " }
vim.opt.shortmess:append("I")
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR><Esc>', { noremap = true, silent = true })
------------ KEYMAPS:
vim.g.mapleader = " "

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

vim.keymap.set('v', '<leader>"', 'c""<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', "<leader>'", "c''<Esc>P", { noremap = true, silent = true })
vim.keymap.set('v', '<leader>(', 'c()<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>{', 'c{}<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>[', 'c[]<Esc>P', { noremap = true, silent = true })

-- Buffers
vim.keymap.set('n', '>', ':bnext<CR>', { noremap = true, silent = true })       -- gn
vim.keymap.set('n', '<', ':bprevious<CR>', { noremap = true, silent = true })   -- gp
vim.keymap.set('n', '<C-x>', ':bdelete<CR>', { noremap = true, silent = true }) -- gw
vim.keymap.set('n', '<leader>be', ':enew<CR>', { noremap = true, silent = true })

-- moving between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })


------------ PLULINS
require('lazy').setup({
  { -- File manager
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end
  },

  { -- Syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'cpp', 'python', 'html', 'css', 'lua' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  { -- Git
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  { -- LSP
    'neovim/nvim-lspconfig',
    config = function()
      require 'lspconfig'.ts_ls.setup {}
    end
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', ---------
    },
    config = function()
      require('cmp').setup({
        sources = {
          { name = 'nvim-lsp' }, ------------------------------------------------------------------
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end
  },

  { -- Commenting
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  { -- Tag highlighting
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  { -- Icons
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end
  },

  { -- Spelling
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  },

  { -- Parenthesis completion
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  { -- Buffers bar
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('barbar').setup({
        animation = false
      })
    end
  },

  { -- Terminal
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<A-h>]],
        direction = "horizontal",
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end
  },

  { -- Themes
    'rafi/awesome-vim-colorschemes',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('yellow-moon') -- desert, yellow-moon, challenger_deep , industry, gruvbox, nord, onedark, pablo, darkblue, blue, PaperColor
      vim.o.termguicolors = true
      vim.o.background = 'dark'
    end
  },

  { -- Char rain
    'eandrju/cellular-automaton.nvim',
    config = function()

    end
  }
})


------------ LSP:
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

local servers = { 'clangd', 'pyright', 'html', 'cssls', 'lua_ls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
end
