vim = vim or {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
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

-- Auto brackets
vim.keymap.set('v', '<leader>"', 'c""<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', "<leader>'", "c''<Esc>P", { noremap = true, silent = true })
vim.keymap.set('v', '<leader>(', 'c()<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>{', 'c{}<Esc>P', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>[', 'c[]<Esc>P', { noremap = true, silent = true })

-- Buffers moving
vim.keymap.set('n', 'gn', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gp', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gw', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'ge', ':enew<CR>', { noremap = true, silent = true })

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

vim.keymap.set('n', '<leader>h', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':wincmd c<CR>', { noremap = true, silent = true })


------------ PLUGINS
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
  -- {
  --   "folke/trouble.nvim",
  --   opts = {},
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       '<leader>t',
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --   },
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "bash", "lua", "asm" },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp_buf.lsp_references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)


        vim.diagnostic.setloclist({ open = true })
        vim.keymap.set('n', '<leader>t', function() vim.diagnostic.setloclist({ open = true }) end, { desc = "Diagnostics List" })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
      end

      local servers = { 'clangd', 'pyright', 'lua_ls', 'rust_analyzer' }
      for _, server in ipairs(servers) do
        vim.lsp.config[server] = {
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
        vim.lsp.enable(server)
      end
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 900 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
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
      ensure_installed = { "lua_ls", "clangd" }
    }
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
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'nvim-mini/mini.tabline',
    version = '*',
    opts = {
      show_icons = false,
      format = nil,
      tabpage_section = 'left'
    }
  },
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end
  },
  {
    "preservim/tagbar",
    config = function()
      vim.g.tagbar_autofocus = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    vim.api.nvim_set_keymap('n', '<leader>,', ':Oil<CR>', { noremap = true, silent = true }),
    opts = {
      default_file_explorer = true,
      columns = {
        "permissions",
        "size",
      },
      buf_options = {
        buflisted = true,
        bufhidden = "hide"
      },
      win_options = {
        wrap = false,
        signcolumn = "yes:2",
        cursorcolumn = false,
        spell = false,
        list = true,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,

      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },
      watch_for_changes = true,

      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          local m = name:match("^%.")
          return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },
      git = {
        add = function(path)
          return true
        end,
        mv = function(src_path, dest_path)
          return true
        end,
        rm = function(path)
          return true
        end,
      },
    },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    config = function()
      require('oil-git-status').setup({
        show_ignored = true,
        symbols = {
          index = {
            ["M"] = "M",
            ["A"] = "A",
            ["D"] = "D",
            ["R"] = "R",
            ["C"] = "C",
            ["U"] = "U",
            ["?"] = "?",
            ["!"] = "!",
          },
          working_tree = {
            ["M"] = "M",
            ["A"] = "A",
            ["D"] = "D",
            ["R"] = "R",
            ["C"] = "C",
            ["U"] = "U",
            ["?"] = "?",
            ["!"] = "!",
          },
        },
      })
    end,
  },
  {
    'rafi/awesome-vim-colorschemes',
    lazy = true,
    -- vim.cmd.colorscheme('purify') -- quiet,OceanicNext,purify,molokai,one,elflord,desert,yellow-moon,challenger_deep,industry,gruvbox,retrobox,nord,onedark,pablo,darkblue,blue,PaperColor
    -- vim.opt.background = 'dark'
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('kanagawa-wave')
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme('tokyonight')
    end
  },
})
