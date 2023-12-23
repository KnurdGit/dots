" Spell

" set spell spelllang=en_us
" UI LAYOUT
set number " show line number
set rnu
set showcmd " shows the last command entered in the very bottom right
set cursorline " show cursor line
set showmatch " show the matching brackets
set mouse=a
" highlight last inserted text
nnoremap gV `[v`]

" Use Y to copy to end of line
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzn
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Moving text vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2'<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" Tab and Untab selected text
vmap <Tab> >gv
vmap <S-Tab> <gv

" open new split panes to right and below
set splitright
set splitbelow

" Give more space for displaying messages.
set colorcolumn=79

" FOLDING
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent  " fold based on indent level
set foldlevel=99

" space open/closes folds
nnoremap <space> za

" SPACES AND TABS
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " tab = 4 spaces
set expandtab " replace tabs with spaces
set smarttab " when deleting whitespace at the beginning of a line, delete 1 tab worth of spaces (for us this is 2 spaces)
set smartindent
set autoindent " enable autoindent
set fileformat=unix

" SEARCH
" Ignore case when searching
set ignorecase
set smartcase
set hlsearch " highlight search results (after pressing Enter)
set incsearch " highlight all pattern matches WHILE typing the pattern

" turn off search highlight
set nohlsearch

" FINDING FILES
set path+=** " search donw into subfolders
set wildmenu " dispaling all matching files when use tabcomplete

" FILE BROWSING
let g:netrw_banner=0 " disable banner
let g:netrw_brows_split=4 " open in prior windows
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view

" COMMANDS
let mapleader = " "

" Backups and undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Scrolling
set scrolloff=8

" OTHER
set nocompatible " disable backward compatability
filetype plugin on " enable plugins
set modelines=1 " enable modeline config
set signcolumn=yes

" italic comments
highlight Comment cterm=italic

" CLIPBOARD
set clipboard+=unnamedplus
set hidden

" Autocomplete
set completeopt=menuone,noselect

" Wrap lines when git commit message
au FileType gitcommit setlocal tw=72

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Pyenv neovim env
let g:python3_host_prog = '~/.pyenv/versions/neovim/bin/python3'

" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Functions
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CAT_IN_TOGA
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Plugins
call plug#begin('~/.config/nvim/plugged')
" Airline bottom panel
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'tpope/vim-surround'
Plug 'yamatsum/nvim-cursorline'
" Color theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Better Comments
Plug 'tpope/vim-commentary'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Better Python Syntax Highlinting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Proper python indent
Plug 'Vimjas/vim-python-pep8-indent'
" Fish shell syntax support
Plug 'dag/vim-fish'
" Asynchronous Lint
Plug 'dense-analysis/ale'
" Coc language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
call plug#end()

lua << END
require('lualine').setup()
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
require("nvim-tree").setup()
END

" Telescope remaps
nnoremap <C-t> <cmd>Telescope find_files<CR>
nnoremap <C-r> <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

" vim-fugitive
nmap <leader>gs :G<CR>
nmap <leader>gl :Gclog<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" Python Specific config
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

" Semshi
set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m
function MyCustomHighlights()
    hi semshiAttribute    ctermfg=49 guifg=#22bf8f
endfunction
autocmd FileType python call MyCustomHighlights()

" Coc Configuration
" Goto definition
nmap <silent> gd <Plug>(coc-definition)
" Open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>
" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Displaying documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Ale Linting
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 0

" nvim-tree
nnoremap <leader>e :NvimTreeToggle <CR>
nnoremap <leader>b :NvimTreeClose <CR>

" QuickFixList
nnoremap <C-k> :w <CR> :cprev<CR>
nnoremap <C-j> :w <CR> :cnext<CR>
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

let g:user_qf_g = 0

fun! ToggleQFList(global)
    if g:user_qf_g == 1
        let g:user_qf_g = 0
        cclose
    else
        let g:user_qf_g = 1
        copen
    end
endfun

" Vagrant syntax
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
" vim:foldmethod=marker:foldlevel=0

" Color Scheme
syntax on " enable syntax highliting
set cursorline
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Example config in VimScript
let g:tokyonight_style = "storm"
let g:tokyonight_italic_functions = 1
"let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }
" let g:airline_theme='night_owl'
let g:lightline = { 'colorscheme': 'tokyonight' }

" Load the colorscheme
colorscheme tokyonight
highlight Comment cterm=italic gui=italic
hi Normal guibg=NONE ctermbg=NONE
