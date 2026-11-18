vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
local map = vim.keymap.set

opt.number = true
opt.numberwidth = 1
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.colorcolumn = '100'
opt.scrolloff = 8
opt.wrap = true
opt.linebreak = true
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { trail = '.', nbsp = '.', tab = '| ' }
opt.fillchars = { eob = ' ' }
opt.shortmess:append('sI')
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.confirm = true
opt.exrc = true
opt.clipboard = 'unnamedplus'

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
  gh("RaafatTurki/hex.nvim"),
  gh("nvim-mini/mini.tabline"),
  gh("nvim-mini/mini.pairs"),
  gh('benomahony/oil-git.nvim'),
  gh('ibhagwan/fzf-lua'),
}, { confirm = false })

vim.cmd.colorscheme('purify') -- quiet,OceanicNext,purify,molokai,one,elflord,desert,yellow-moon,challenger_deep,industry,gruvbox,retrobox,nord,onedark,pablo,darkblue,blue,PaperColor

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
  },
  signature = { enabled = true },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local function bmap(lhs, rhs, desc)
      map('n', lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end
    bmap('gd', vim.lsp.buf.definition)
    bmap('gr', vim.lsp.buf.references)
    bmap('gi', vim.lsp.buf.implementation)
    bmap('gt', vim.lsp.buf.type_definition)
    bmap('K', vim.lsp.buf.hover)
    bmap('<leader>ca', vim.lsp.buf.code_action)
    bmap('<leader>r', vim.lsp.buf.rename)
    bmap('<leader>f', function() vim.lsp.buf.format() end)
    bmap('<leader>g', vim.diagnostic.setloclist)
    bmap('<leader>e', vim.diagnostic.open_float)
    bmap('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
    bmap(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
  end,
})

map('n', '<leader>gc', '<cmd>Git commit<cr>')
map('n', '<leader>ga', '<cmd>Git commit --amend<cr>')

require('mason').setup({ PATH = "append" })

require('mason-lspconfig').setup({
  automatic_enable = false,
})

vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls', 'rust_analyzer', 'hls', 'gopls' })

require("aerial").setup({ backends = { "lsp", "treesitter" } })
map('n', '<leader>a', '<Cmd>AerialToggle!<CR>')

require("oil").setup({ view_options = { show_hidden = true }, skip_confirm_for_simple_edits = true })
map('n', '<leader>,', '<cmd>Oil<cr>')

require('oil-git').setup()
require("hex").setup()

require('mini.tabline').setup()
require('mini.pairs').setup()

require("gitsigns").setup({
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function bmap(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = buf }) end
    bmap("]j", function() gs.nav_hunk("next") end)
    bmap("[j", function() gs.nav_hunk("prev") end)
    bmap("<leader>hs", gs.stage_hunk)
    bmap("<leader>hp", gs.preview_hunk)
    bmap("<leader>hr", gs.reset_hunk)
    bmap("<leader>hb", function() gs.blame_line({ full = true }) end)
  end,
})

local fzf = require('fzf-lua')
fzf.setup({ 'default-title' })

map('n', '<leader>ff', fzf.files)
map('n', '<leader>fg', fzf.live_grep)
map('n', '<leader>fb', fzf.buffers)
map('n', '<leader>fr', fzf.oldfiles)
map('n', '<leader>fh', fzf.helptags)
map('n', '<leader>fs', fzf.lsp_document_symbols)
map('n', '<leader>fS', fzf.lsp_live_workspace_symbols)
map('n', '<leader>f.', fzf.resume)
map('n', '<leader>*', fzf.grep_cword)
map('v', '<leader>*', fzf.grep_visual)
