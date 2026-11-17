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

vim.schedule(function()
  vim.cmd("packadd nvim.undotree")
  vim.keymap.set("n", "<leader>u", vim.cmd.Undotree)
end)

local gh = function(name)
  return 'https://github.com/' .. name
end

vim.pack.add({
  { src = gh('rafi/awesome-vim-colorschemes') },
  { src = gh('nvim-mini/mini.nvim') },
}, { confirm = false })
