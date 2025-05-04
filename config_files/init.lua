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
vim.opt.scrolloff = 8
vim.opt.hlsearch = true
vim.opt.timeoutlen = 300
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append("sI")
vim.opt.fillchars = { eob = " " }
vim.opt.colorcolumn = "80"


------------ KEYMAPS:
vim.g.mapleader = " "

vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('v', '<leader>"', 'c""<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', "<leader>'", "c''<Esc>P", { noremap = true, silent = true })
vim.keymap.set('v', '<leader>9', 'c()<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>{', 'c{}<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>[', 'c[]<Esc>P', { noremap = true, silent = true })

-- Buffers
vim.keymap.set('n', 'gn', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gp', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gw', ':bdelete<CR>', { noremap = true, silent = true }) -- <C-w>
vim.keymap.set('n', '<leader>be', ':enew<CR>', { noremap = true, silent = true })

-- moving between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set("t", "<S-Space>", "<Space>", { noremap = true, silent = true })


------------ PLULINS
require('lazy').setup({
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        view = { width = 26 },
        filters = { dotfiles = false }
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "python", "html", "css", "lua", "asm", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
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

      local servers = { 'clangd', 'pyright', 'html', 'cssls', 'lua_ls' }
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
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('barbar').setup({
        animation = false
      })
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<A-h>]],
        direction = "horizontal",
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end
  },
  {
    'rafi/awesome-vim-colorschemes',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('gruvbox') -- one, elflord, desert, yellow-moon, challenger_deep, industry, gruvbox, retrobox, nord, onedark, pablo, darkblue, blue, PaperColor
      vim.opt.background = 'dark'

      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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
  {
    'tanvirtin/vgit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function() require("vgit").setup() end,
  }
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
  pattern = 'c,cpp',
  callback = function()
    vim.keymap.set('n', '<C-b>', ':!make && make clean:r<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-f>', ':!clang-format --style Chromium -i %<CR>', { noremap = true, silent = true })
  end,
})
