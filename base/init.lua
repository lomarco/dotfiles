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
vim.loader.enable()
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
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.timeoutlen = 400
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "80"
vim.opt.shortmess:append("sI")
vim.opt.fillchars = { eob = " " }


------------ KEYMAPS:
vim.g.mapleader = " "

-- Escape alias
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-c>', '<Esc>', { noremap = true, silent = true })

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

-- Terminal
function ToggleTerminal()
  local terminal_bufnr = vim.g.terminal_bufnr or nil

  if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
    local terminal_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_bufnr then
        terminal_win = win
        break
      end
    end
    if terminal_win then
      vim.api.nvim_win_close(terminal_win, true)
    else
      vim.cmd("botright split")
      vim.api.nvim_win_set_buf(0, terminal_bufnr)
    end
  else
    vim.cmd("botright split")
    vim.cmd("terminal")
    vim.g.terminal_bufnr = vim.api.nvim_get_current_buf()
    vim.cmd("startinsert")
  end
end
vim.api.nvim_set_keymap('n', '<leader>h', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':wincmd c<CR>', { noremap = true, silent = true })


------------ PLULINS
require('lazy').setup({
  {
    'github/copilot.vim',
    lazy = true,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.keymap.set('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
      vim.keymap.set('i', '<C-k>', 'copilot#Dismiss()', { expr = true, silent = true, noremap = true })
    end,
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
      { '<C-p>',      function() require('telescope.builtin').git_files() end,  desc = 'Find Files' },
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
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>t",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "python", "lua", "asm" },
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

      local servers = { 'clangd', 'pyright', 'lua_ls', 'rust_analyzer' }
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
          { name = 'path',     priority = 50 },
          { name = 'buffer',   priority = 10 },
        },
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
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
    "williamboman/mason.nvim",
    opts = {},
    lazy = false
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      automatic_installation = true,
    }
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
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
  {
    'rafi/awesome-vim-colorschemes',
    config = function()
      vim.cmd.colorscheme('OceanicNext')
      -- purify,vscode,molokai,one,elflord,desert,yellow-moon,challenger_deep,industry,gruvbox,retrobox,nord,onedark,pablo,darkblue,blue,PaperColor
      vim.opt.background = 'dark'
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
    keys = {
      { "<leader>A",     function() require("harpoon"):list():prepend() end,                                desc = "Harpoon Prepend File" },
      { "<leader>a",     function() require("harpoon"):list():add() end,                                    desc = "Harpoon Add File" },
      { "<leader>m",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Toggle Menu" },
      { "<C-h>",         function() require("harpoon"):list():select(2) end,                                desc = "Harpoon Select 1" },
      { "<C-t>",         function() require("harpoon"):list():select(2) end,                                desc = "Harpoon Select 2" },
      { "<C-n>",         function() require("harpoon"):list():select(3) end,                                desc = "Harpoon Select 3" },
      { "<C-s>",         function() require("harpoon"):list():select(4) end,                                desc = "Harpoon Select 4" },
      { "<leader><C-h>", function() require("harpoon"):list():replace_at(1) end,                            desc = "Harpoon Replace At 1" },
      { "<leader><C-t>", function() require("harpoon"):list():replace_at(2) end,                            desc = "Harpoon Replace At 2" },
      { "<leader><C-n>", function() require("harpoon"):list():replace_at(3) end,                            desc = "Harpoon Replace At 3" },
      { "<leader><C-s>", function() require("harpoon"):list():replace_at(4) end,                            desc = "Harpoon Replace At 4" },
    },
  },
  {
    'davvid/harpoon-term.nvim',
    keys = function()
      local harpoon_term = require('harpoon_term')
      return {
        {
          '<leader>t1',
          function()
            harpoon_term.toggle_floating_window(1)
          end,
          desc = 'HarpoonTerm Toggle Floating Window with Terminal #1',
        },
        {
          '<leader>t2',
          function()
            harpoon_term.toggle_floating_window(2)
          end,
          desc = 'HarpoonTerm Toggle Floating Window with Terminal #2',
        },
        {
          '<leader><leader>1',
          function()
            harpoon_term.goto_terminal(1)
          end,
          desc = 'HarpoonTerm Switch to Terminal #1',
        },
        {
          '<leader><leader>2',
          function()
            harpoon_term.goto_terminal(2)
          end,
          desc = 'HarpoonTerm Switch to Terminal #2',
        },
      }
    end,
  },
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
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
