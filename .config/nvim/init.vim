"""""""""""""""""""""""
"
" ░█░█░▀█▀░█▄█░█▀▄░█▀▀
" ░▀▄▀░░█░░█░█░█▀▄░█░░
" ░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀
"
"""""""""""""""""""""""

" Install vim-plug if we don't already have it
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source /home/tetsomina/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

"Completion plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neoinclude.vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'ujihisa/neco-look'
"Programming plugins
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-autoformat/vim-autoformat'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
" Notes/ task
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'tools-life/taskwiki'
" writing plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'preservim/vim-litecorrect'
"Misc/useful plugins
"Plug 'jooize/vim-colemak'
Plug 'AlessandroYorba/Alduin', {'branch': 'master'}
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'semanser/vim-outdated-plugins'
Plug 'easymotion/vim-easymotion'
Plug 'farmergreg/vim-lastplace'
Plug 'chrisbra/Colorizer'
Plug 'psliwka/vim-smoothie'

call plug#end()

" Colorscheme settings
"alduin
let g:alduin_Shout_Fire_Breath = 0
let g:alduin_Shout_Aura_Whisper = 1

let g:colorizer_auto_color = 1

set nocompatible
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
syntax enable
colorscheme alduin
set termguicolors
set splitbelow
set splitright
set clipboard+=unnamedplus
set hlsearch
set incsearch
set hidden
set ttyfast
set lazyredraw
set number
set encoding=utf-8
set filetype=on
set autoindent
set autoread
set belloff=all
set shortmess=ASF
set nofsync

"Deoplete settings
let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
call deoplete#custom#option({
      \ 'auto_complete_popup': 'manual',
      \ })
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ deoplete#can_complete() ? deoplete#complete() : ''
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set titlestring=vim\ %F

let g:ascii = [
            \ ' ██▒   █▓ ██▓ ███▄ ▄███▓',
            \ '▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
            \ ' ▓██  █▒░▒██▒▓██    ▓██░',
            \ '  ▒██ █░░░██░▒██    ▒██ ',
            \ '   ▒▀█░  ░██░▒██▒   ░██▒',
            \ '   ░ ▐░  ░▓  ░ ▒░   ░  ░',
            \ '   ░ ░░   ▒ ░░  ░      ░',
            \ '     ░░   ▒ ░░      ░   ',
            \ '      ░   ░         ░   ',
            \ '     ░                  ',
            \]

let g:startify_custom_header =
            \ 'startify#center(g:ascii)'

" air-line fonts
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ' ' "''
let g:airline_left_alt_sep = ' ' "''
let g:airline_right_sep = ' ' "''
let g:airline_right_alt_sep = ' ' "''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.dirty=' '

" airline tabs
let g:airline#extensions#tabline#enabled = 1

" setup for goyo & limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 100
let g:goyo_height = 95
let b:code = 'no'

"Toggle Goyo and Limelight on and off
map <C-g> :Goyo<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" enable mouse scroll
set mouse=a

" Nerdtree
"autocmd vimenter * NERDTree
map <C-d> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


" Yank whole line w/o newline
nmap Y ^y$

" mutt stuff
augroup filetypedetect
    " Mail
    au BufRead *mutt-* set tw=72
    au BufRead *mutt-* set wrap
    au BufRead *mutt-* set spell
    autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END

" airline theme
let g:airline_theme='alduin'

"Indent line settings
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['startify']
set list lcs=tab:\│\
set list

" Do not show any message if all plugins are up to date. 0 by default
let g:outdated_plugins_silent_mode = 1

"Vimwiki settings
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger='<c-s>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Highlight cursor location
set cursorline
"set cursorcolumn

" Autoformat settings
let g:autoformat_autoindent = 0
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1

" Format on save
"au BufWrite * :Autoformat

" Change side symbols
let g:ale_sign_error = '▍'
let g:ale_sign_warning = '▍'

let g:gitgutter_sign_added              = '▍'
let g:gitgutter_sign_modified           = '▍'
let g:gitgutter_sign_modified_removed   = '▍'
let g:gitgutter_sign_removed            = '▍'
let g:gitgutter_sign_removed_first_line = '▍'
let g:gitgutter_sign_removed_above_and_below = '▍'

" vim-pandoc settings
let g:pandoc#command#latex_engine = 'tectonic'
let g:pandoc#formatting#mode = 'ha'
au BufWrite *.pandoc,*.pdc,*.pd,*.pdk :Pandoc pdf

call deoplete#custom#var('omni', 'input_patterns', {
  \ 'pandoc': '@'
  \})

" For undercurl spellchecker (st only)
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Tab bindings
nnoremap tn  :tabnew<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tx  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Change cursor shape based on current mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" indent wrapped lines correctly:
set breakindent
set showbreak=..

" Convert tabs to 4 spaces
set tabstop=4       " The width of a TAB is set to 4. It is still a \t.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set smarttab        " TABs will go to next indent line
