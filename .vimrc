syntax on
set encoding=utf-8
set ruler

if has("win32")
	set runtimepath=~/.vim,$VIMRUNTIME
	set backspace=indent,eol,start whichwrap+=<,>,[,]
	imap <C-S-V> <ESC>"+gP
endif

colorscheme jellybeans

set t_Co=256

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none

filetype plugin indent on

set incsearch
set hlsearch
set number
set showcmd
set autoindent

set tabstop=2 
set shiftwidth=2
set expandtab

autocmd FileType cs set omnifunc=cscomplete#Complete
autocmd FileType cs set foldmethod=marker 

autocmd BufRead,BufNewFile *.spec.js  set filetype=javascript.javascript-jasmine
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb

let g:user_zen_expandabbr_key = '<C-e>'

map ff :FufFile **/<CR>
map <F2> :set paste<CR>
map <F3> :set nopaste<CR>
map <C-l> :let @/=""<CR>
nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv
