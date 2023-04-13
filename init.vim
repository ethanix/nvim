" Address: $HOME/.config/nvim/init.vim
" Date: Fri Apr 7 CST 2023

" ===
" Install plug.vim
" ===
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" Essential setting
" ===
let mapleader=" "
let &t_ut=''
set autochdir
set exrc
set secure
set number
set relativenumber
set cursorline
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set lazyredraw
set visualbell
set colorcolumn=100
set updatetime=100
set virtualedit=block
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
set hlsearch
set incsearch
set ignorecase
set smartcase
exec 'nohlsearch'
noremap <LEADER><CR> :nohlsearch<CR>


" ===
" === Window Spliting
" ===
set splitright
set splitbelow
nnoremap z\ :vs<CR>
nnoremap z- :sp<CR>
nnoremap t- :ter<CR>
nnoremap zj <c-w>j
nnoremap zk <c-w>k
nnoremap zh <c-w>h
nnoremap zl <c-w>l


" ===
" === Code Folding
" ===
set foldmethod=manual
" zc : close the current fold
" zo : open the current fold
" zd : delete the current fold
" [z : move to the top of the current fold
" ]z : move to the bottom of the current fold
" zf : fold the selected area
" zfap : fold the whole paragraph
" zfnj / zfnk / zfgg / zfG


" ===
" === FileType
" ===
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
augroup mine | autocmd BufRead,BufNewFile *.m   set filetype=m
augroup mine | autocmd BufRead,BufNewFile *.srt set filetype=srt
augroup mine | autocmd BufRead,BufNewFile *.ass set filetype=ass
augroup mine | autocmd BufRead,BufNewFile *.eif set filetype=eif
augroup mine | autocmd BufRead,BufNewFile *.tex set filetype=tex


" ===
" === CompileRunGcc
" ===
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec 'w'
  if &filetype ==# 'sh'
      :!time bash %
  elseif &filetype == 'c'
      set splitbelow
      :sp
      term gcc % -o %< && time ./%<
  elseif &filetype == 'cpp'
      set splitbelow
      exec "!g++ -std=c++11 % -Wall -o %<"
      :sp
      :term ./%<
  elseif &filetype ==# 'python'
      set splitbelow
      :sp
      :term python3 %
  elseif &filetype ==# 'html'
      silent! exec '!chromium % &'
  endif
endfunc


" ===
" === Vim Plugins
" ===
call plug#begin('~/.config/nvim/plugged')

" gruvbox vim theme
Plug 'morhetz/gruvbox'

" vim status bar dress
Plug 'vim-airline/vim-airline'

" airline theme
Plug 'vim-airline/vim-airline-themes'

" ---

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" fuzzy finder for vim
Plug 'junegunn/fzf.vim'


" Tag bar
Plug 'majutsushi/tagbar'

" Ctags
Plug 'universal-ctags/ctags'

" ---

" multiple cursors
Plug 'terryma/vim-multiple-cursors'

" cursor underline
Plug 'itchyny/vim-cursorword'

" highliht some words you like
Plug 'lfv89/vim-interestingwords'

" file superlink in vim
Plug 'amix/open_file_under_cursor.vim'

" ---

" Quick choose
Plug 'gcmt/wildfire.vim'

" ---

" Indent line
Plug 'Yggdroot/indentLine'

" Colorful Brackets
Plug 'frazrepo/vim-rainbow'

" ---

" python autoformat
Plug 'Chiel92/vim-autoformat'

" error check (python)
Plug 'dense-analysis/ale'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" C & C++ highlight
Plug 'bfrg/vim-cpp-modern'

" ---

" vim bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" vim home page
Plug 'mhinz/vim-startify'

call plug#end()


" ===
" === vim-interestingwords
" ===
let g:interestingWordsRandomiseColors = 1
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
nnoremap <silent> <leader>K :call UncolorAllWords()<CR>
nnoremap <silent> n :call WordNavigation('forward')<CR>
nnoremap <silent> N :call WordNavigation('backward')<CR>


" ===
" === vim-bookmarks
" ===
let g:bookmark_sign = '⚑'
let g:bookmark_annotation_sign = ''
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
  nnoremap mm :BookmarkToggle<CR>
  nnoremap mi :BookmarkAnnotate<CR>
  nnoremap mn :BookmarkNext<CR>
  nnoremap mp :BookmarkPrev<CR>
  nnoremap ma :BookmarkShowAll<CR>
  nnoremap mc :BookmarkClear<CR>
  nnoremap mx :BookmarkClearAll<CR>
  nnoremap mkk :BookmarkMoveUp
  nnoremap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
  unmap mm
  unmap mi
  unmap mn
  unmap mp
  unmap ma
  unmap mc
  unmap mx
  unmap mkk
  unmap mjj
endfunction
augroup mine | autocmd BufEnter * :call BookmarkMapKeys()
augroup mine | autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()


" ===
" === tagbar
" ===
" 'universal-ctags/ctags' is required
let g:tagbar_ctags_bin = '/usr/local/bin/exctags'
nnoremap tg :TagbarToggle<CR>


" ===
" === vim-airline
" ===
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
noremap <c-j> :bp<CR>
noremap <c-J> :bn<CR>
noremap qq :Bdelete<CR>


" ===
" === vim-airline-themes
" ===
" AirLineTheme: dark soda luna
augroup mine | autocmd VimEnter * AirlineTheme soda
let g:lightline = {
      \     'active': {
      \     'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
      \     'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
      \     }
      \ }


" ===
" === indentLine
" ===
let g:indentLine_color_gui = '#ED6824'
let g:indentLine_char_list = ['¦', '┆', '┊','╏','┇','┋','│','┃','║']


" ===
" === vim-rainbow
" ===
augroup mine | autocmd FileType * call rainbow#load()
let g:rainbow_active = 1
let g:rainbow_load_separately = [
      \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
      \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
      \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
      \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
      \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" ===
" === wildfire.vim
" ===
map <leader>n <Plug>(wildfire-fuel)
map <leader>m <Plug>(wildfire-water)
let g:wildfire_objects = {
      \'*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it','i>'],
      \'html,xml' : ['at','it'],
      \}

" ===
" === vim-autoformat
" ===
" c/cpp : astyle
" python: autopep8 (pip3 is recommended)
noremap <c-d> :Autoformat<CR>:w<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python = ['autopep8']
let g:formatterpath = ['$HOME/.vim/astyle/build/gcc/bin']


" ===
" === ale
" ===
" checking programs:
" vim   : vint (pip3)
" c     : gcc (pacman)
" cpp   : gcc (pacman)
" html  : proselint (pip3)
" css   : prettier (pacman)
" shell : shellcheck (pacman)
" python: pylint (pip3)
" fixing programs:
" python: autopep8 & yapf (pip3)
let g:ale_sign_error = '>'
let g:ale_sign_warning = '='
let g:ale_echo_msg_error_str = '!'
let g:ale_echo_msg_warning_str = '+'
let g:ale_echo_msg_format = '%linter% %severity% :%s'
let b:ale_linters = {
      \'c': ['gcc'],
      \'cpp': ['gcc'],
      \'vim': ['vint'],
      \'css': ['prettier'],
      \'sh': ['shellcheck'],
      \'python': ['pylint'],
      \'html': ['proselint','prettier'],
      \}
let b:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace'],
      \'python': ['autopep8', 'yapf'],
      \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_changed = 0
let g:ale_lint_on_text_changed = 'never'


" ===
" === vim-cpp-modern
" ===
let c_no_curly_error = 1
let g:cpp_posix_standard = 1
let g:cpp_simple_highlight = 0
let g:cpp_concepts_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_no_function_highlight = 0
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_named_requirements_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1


" ===
" === gruvbox
" ===
colorscheme gruvbox
set background=dark
" Transparent:
" highlight Normal guibg=NONE ctermbg=None


" ===
" === coc.nvim
" ===
let g:coc_global_extensions = [
            \'coc-marketplace',
            \'coc-sh',
            \'coc-python',
            \'coc-vimlsp',
            \'coc-clangd'
            \]


" ===
" === vim-easymotion
" ===
let g:EasyMotion_smartcase = 1
nmap gw <Plug>(easymotion-s2)
nmap gl <Plug>(easymotion-overwin-line)
nmap gn <Plug>(easymotion-next)
nmap gm <Plug>(easymotion-prev)


" ===
" === fzf.vim
" ===
let g:fzf_preview_window = 'right:40%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }


" ===
" === File Header
" ===
func FileHeader()

  if &filetype ==# 'sh'
    call setline(1,'#! /bin/bash')
  endif
endfunc
autocmd BufNewFile * exec ":call FileHeader()"

source ~/.config/nvim/shortcut.vim
