call pathogen#infect()
syntax on

if has("win32")
	set runtimepath=~/.vim,$VIMRUNTIME
	set backspace=indent,eol,start whichwrap+=<,>,[,]
	imap <C-S-V> <ESC>"+gP
endif

set t_Co=256
colorscheme jellybeans

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none

filetype plugin indent on

set number
set ruler
set cursorline
set showcmd
set incsearch
set hlsearch
set autoindent
set expandtab

set encoding=utf-8
set laststatus=2
set tabstop=2 
set shiftwidth=2

autocmd FileType python set tabstop=4 
autocmd FileType python set shiftwidth=4

autocmd BufRead,BufNewFile *.spec.js  set filetype=javascript.javascript-jasmine
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb

let g:user_zen_expandabbr_key = '<C-e>'

map ,f :FufFile **/<CR>
map ,t :NERDTreeToggle<CR>
map \o o<ESC>
map \O O<ESC>
map 1y "+y<CR>
map 1p "+p<CR>

map <F2> :set paste<CR>
map <F3> :set nopaste<CR>
map <C-l> :let @/=""<CR>

nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv
"format xml
"!xmllint --format --recover -

autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
    \ call mkdir($HOME . "/.vim") |
    \ endif |
    \ execute "mksession! " . $HOME . "/.vim/session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/session.vim") |
    \ execute "source " . $HOME . "/.vim/session.vim"
