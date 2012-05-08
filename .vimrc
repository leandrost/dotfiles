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

autocmd InsertEnter * hi StatusLine term=reverse ctermbg=227
autocmd InsertLeave * hi StatusLine term=reverse ctermfg=16 ctermbg=7

set hlsearch
set cursorline
set number
set ruler
set showcmd
set laststatus=2
set mouse=a
set encoding=utf-8

set incsearch

set autoindent
set expandtab
set tabstop=2 
set shiftwidth=2

autocmd FileType python set tabstop=2 
autocmd FileType python set shiftwidth=2

filetype plugin indent on
autocmd BufRead,BufNewFile *.spec.js  set filetype=javascript.javascript-jasmine
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.exbl  set filetype=ruby.html
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

function! MyTabLine()
  let s = ''
  let wn = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let wn = tabpagewinnr(i,'$')

    let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
    let s .= ' '
    let s .= i
    if tabpagewinnr(i,'$') > 1
      let s .= '/'
      let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
      let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
    end

    let s .= ' %*'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
      let file = '[No Name]'
    endif
    let s .= file
    let s .= ' '
    let s .= (i == t ? '%m' : '')
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= '%=%#TabLine#%999Xclose'
  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

set tabline=%!MyTabLine()
set tabpagemax=15
highlight TabLineSel term=bold cterm=bold ctermfg=145 ctermbg=none
highlight TabWinNumSel term=bold cterm=bold ctermfg=208 ctermbg=none
highlight TabNumSel term=bold cterm=bold ctermfg=11 ctermbg=none

highlight TabLine term=underline ctermfg=16 ctermbg=145
highlight TabWinNum term=bold cterm=bold ctermfg=161 ctermbg=145
highlight TabNum term=bold cterm=bold ctermfg=88 ctermbg=145
      

