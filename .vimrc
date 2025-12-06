" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" =====================================
" Base settings
" =====================================
let mapleader=" "
set nocompatible
filetype plugin indent on
set clipboard=unnamedplus
set nobackup noswapfile nowritebackup hidden mouse=a
set number relativenumber numberwidth=1
set nowrap termguicolors nocursorline
set hlsearch
set timeoutlen=400
set signcolumn=yes
set shortmess+=sI
set fillchars=eob:\ 
set colorcolumn=80
syntax on
set background=dark
colorscheme murphy "zaibatsu
highlight EndOfBuffer ctermfg=0 ctermbg=0
set lazyredraw
set tabstop=2 shiftwidth=2 expandtab smartindent
set ignorecase smartcase
set updatetime=100
set showtabline=2

function! BuffersList()
  let s = ''
  for buf in range(1, bufnr('$'))
    if buflisted(buf)
      let name = bufname(buf) == '' ? '[No Name]' : fnamemodify(bufname(buf), ':t')
      if buf == bufnr('%')
        let s .= '%#TabLineSel#' . ' ' . name . ' '
      else
        let s .= '%#TabLine#' . ' ' . name . ' '
      endif
    endif
  endfor
  return s
endfunction

set tabline=%!BuffersList()

"====================================
" Cursor settings
" ===================================
let &t_EI = "\e[1 q" " Normal mode
let &t_SI = "\e[5 q" " Insert mode
let &t_SR = "\e[4 q" " Replays mode
" '\e0 q'	Blinking block
" '\e1 q'	Blinking block
" '\e2 q'	Steady block
" '\e3 q' Blinking underline
" '\e4 q'	Steady underline
" '\e5 q'	Blinking bar
" '\e6 q'	Steady bar

" =====================================
" Netrw
" =====================================
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 16
" nnoremap <C-n> :Lexplore<CR>

" =====================================
" Keymaps
" =====================================
vnoremap <leader>" c""<Esc>P
vnoremap <leader>' c''<Esc>P
vnoremap <leader>9 c()<Esc>P
vnoremap <leader>{ c{}<Esc>P
vnoremap <leader>[ c[]<Esc>P

nnoremap gn :bnext<CR>
nnoremap gp :bprevious<CR>
nnoremap gw :bdelete<CR>
nnoremap <leader>be :enew<CR>
nnoremap <leader>b :buffer<Space>

nnoremap <Esc> :noh<CR><Esc>

inoremap jk <ESC>

" nnoremap <C-k> :%!clang-format<CR>
nnoremap <C-K> :%!clang-format -style=file:$HOME/.config/clang-format/clang-format<CR>


" =====================================
" Vim-plug
" =====================================
" =====================================
" Plugins
" =====================================
" call plug#begin('~/.vim/plugged')
" Plug 'preservim/nerdtree'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'easymotion/vim-easymotion'
" Plug 'preservim/tagbar'
" Plug 'github/copilot.vim'
" Plug 'mbbill/undotree'
" Plug 'matze/vim-move'
" Plug 'voldikss/vim-floaterm'
" Plug 'tpope/vim-commentary'
" Plug 'jiangmiao/auto-pairs'
" Plug 'airblade/vim-gitgutter'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'ycm-core/YouCompleteMe'
" call plug#end()
"
" " =====================================
" " Setting Plugins
" " =====================================
"
" "Nerdtree
" nnoremap <C-n> :NERDTreeToggle<CR>
"
" " Fzf
" nnoremap <leader>f :Files<CR>
"
" " Tagbar
" nnoremap <leader>t :TagbarToggle<CR>
" let g:tagbar_width=50
" let g:tagbar_autofocus=1
" let g:tagbar_sort=0
" let g:tagbar_compact=1
" let g:tagbar_autoclose=0
"
" " vim-floaterm
" nnoremap <silent> <leader>h :FloatermToggle<CR>
"
" " Vim-lsp
" augroup lsp_mgr
"   autocmd!
" augroup END
"
" nmap <silent> gd :LspDefinition<CR>
" nmap <silent> gr :LspReferences<CR>
" nmap <silent> g :LspHover<CR>
" nmap <silent> <leader>rn :LspRename<CR>
" nmap <silent> <leader>ca :LspCodeAction<CR>
"
" autocmd BufWritePre * :LspCodeAction sync
"
" "setlocal omnifunc=lsp#complete
" setlocal omnifunc=vim_lsp#complete
" inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
