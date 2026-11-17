vim.loader.enable()

local opt = vim.opt

opt.number = true
opt.numberwidth = 1
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = true
opt.linebreak = true
opt.termguicolors = true
opt.hlsearch = true
opt.timeoutlen = 400
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.colorcolumn = "100"
opt.shortmess:append("sI")
opt.fillchars = { eob = " " }
opt.list = true
opt.listchars = { trail = '.', nbsp = '.', tab = '| ' }
opt.undofile = true


vim.g.mapleader = " "

local map = vim.keymap.set

map('i', 'jk', '<Esc>')

map('v', '<leader>"', 'c""<Esc>P')
map('v', "<leader>'", "c''<Esc>P")
map('v', '<leader>`', 'c``<Esc>P')
map('v', '<leader>(', 'c()<Esc>P')
map('v', '<leader>{', 'c{}<Esc>P')
map('v', '<leader>[', 'c[]<Esc>P')

map('n', 'gn', '<Cmd>bnext<CR>')
map('n', 'gp', '<Cmd>bprevious<CR>')
map('n', 'gw', '<Cmd>bdelete<CR>')
map('n', 'ge', '<Cmd>enew<CR>')

map('n', '<leader>u', function()
  vim.cmd.packadd('nvim.undotree')
  require('undotree').open()
end)

local gh = function(name)
  return 'https://github.com/' .. name
end

vim.pack.add({
  gh('rafi/awesome-vim-colorschemes'),
  gh('saghen/blink.cmp'),
  gh('saghen/blink.lib'),
  gh('lewis6991/gitsigns.nvim'),
  gh('tpope/vim-fugitive'),
  gh('neovim/nvim-lspconfig'),
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  gh("stevearc/aerial.nvim"),
  gh("stevearc/oil.nvim"),
  gh("lambdalisue/vim-lese"),
  gh("RaafatTurki/hex.nvim"),
  gh("nvim-mini/mini.tabline"),
  gh("nvim-mini/mini.pairs"),
  gh("nvim-mini/mini.comment"),
  gh("nvim-mini/mini.surround"),
  gh('benomahony/oil-git.nvim'),
}, { confirm = false })

vim.cmd.colorscheme('purify') -- quiet,OceanicNext,purify,molokai,one,elflord,desert,yellow-moon,challenger_deep,industry,gruvbox,retrobox,nord,onedark,pablo,darkblue,blue,PaperColor

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  keymap = { preset = "default" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
    },
  },

  signature = {
    enabled = true,
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local function map(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { silent = true, buffer = ev.buf })
    end
    map('gd', vim.lsp.buf.definition)
    map('gr', vim.lsp.buf.references)
    map('gi', vim.lsp.buf.implementation)
    map('gt', vim.lsp.buf.type_definition)
    map('K', vim.lsp.buf.hover)
    map('<leader>ca', vim.lsp.buf.code_action)
    map('<leader>r', vim.lsp.buf.rename)
    map('<leader>f', function() vim.lsp.buf.format() end)
    map('<leader>g', vim.diagnostic.setloclist)
    map('<leader>e', vim.diagnostic.open_float)
    map('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
    map(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
  end,
})

map('n', '<leader>gc', '<cmd>Git commit<cr>')
map('n', '<leader>ga', '<cmd>Git commit --amend<cr>')

require('mason').setup()

require('mason-lspconfig').setup({
  automatic_enable = false,
})

vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls', 'rust_analyzer', 'hls', 'gopls' })

require("aerial").setup({ backends = { "lsp", "treesitter" } })
map('n', '<leader>a', '<Cmd>AerialToggle!<CR>')

require("oil").setup({ view_options = { show_hidden = true }, skip_confirm_for_simple_edits = true })
map('n', '<leader>,', '<cmd>Oil<cr>')

require('oil-git').setup()

map("n", "<leader>ff", "<cmd>Lese file<cr>")
map("n", "<leader>fb", "<cmd>Lese buffer<cr>")
map("n", "<leader>fr", "<cmd>Lese oldfiles<cr>")
map("n", "<leader>fg", "<cmd>Lese grep<cr>")

require("hex").setup()

require('mini.tabline').setup()
require('mini.pairs').setup()
require('mini.comment').setup()
require('mini.surround').setup()

require("gitsigns").setup({
  on_attach = function(buf)
    local gs, b = require("gitsigns"), { buffer = buf }
    map('n', ']c', function() gs.next_hunk() end)
    map('n', '[c', function() gs.prev_hunk() end)
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
  end,
})
