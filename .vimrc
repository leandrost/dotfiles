call pathogen#infect()
syntax on
set encoding=utf-8
set nowrap

set autoindent
filetype plugin indent on
set expandtab
set tabstop=2 
set shiftwidth=2
autocmd FileType python set tabstop=4 
autocmd FileType python set shiftwidth=4

if has("win32")
	set runtimepath=~/.vim,$VIMRUNTIME
	set backspace=indent,eol,start whichwrap+=<,>,[,]
	imap <C-S-V> <ESC>"+gP
endif

set t_Co=256
colorscheme jellybeans

set number
set hlsearch
set incsearch

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none

set laststatus=2
autocmd InsertEnter * hi StatusLine term=reverse ctermbg=227
autocmd InsertLeave * hi StatusLine term=reverse ctermfg=16 ctermbg=7

set ruler
set showcmd
set mouse=a

"let javaScript_fold=1
"let ruby_fold=1
"let html_fold=1
"autocmd Syntax rb,javascript,vim,gitcommit,xml,html,xhtml set foldmethod=syntax
"autocmd Syntax rb,javascript,vim,gitcommit,xml,html,xhtml normal zR
autocmd BufRead,BufNewFile *.spec.js  set filetype=javascript.javascript-jasmine
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.exbl  set filetype=ruby.html
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb
autocmd BufRead,BufNewFile *.ofx set filetype=xml

let g:user_zen_expandabbr_key = '<C-e>'

"BACKGROUND CONFIG
let g:bg_flag = 0

function! ShowBackground()
  let g:bg_flag = 1
  highlight Normal ctermbg=0 
  colorscheme jellybeans
endfunction 

function! HideBackground()
  let g:bg_flag = 0
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr ctermbg=none
endfunction
function! ToggleBackground()
    echo g:bg_flag
  if g:bg_flag == 0
    call ShowBackground() 
  else
    call HideBackground()
  endif
endfunction

"CUSTOM MAPS
map <C-l> :let @/=""<CR>

map <F2> :set paste<CR>
map <F3> :set nopaste<CR>
map <F4> :!xmllint --format --recover -

map \p "+p

map \y "+y
map \yy "+yy
map \yw "+yw
map \yb "+yb
map \sl :Spec line('.')<CR>
map \sf :Spec line('.')." --fail-fast"<CR>
map \s% :Spec ""<CR>
map \ss :let @+= "rspec ".expand("%")<CR>
map \s- :Spec "--fail-fast"<CR>
omap \r :Spec "-"<CR>
map \r :let @+= "rspec ".expand("%")<CR>

nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv

map v$$ vg_
map cu ct_
map cU F_lct_

"RSPEC
function! RunRspec(args)
  let args = '' 
  if a:args != ''
    let args .= ' -l '.a:args 
  end
  if a:args == '-'
    let cmd = g:last_rspec
  else
    let cmd = "rspec ".expand("%").args
  end
  execute 'silent execute "!echo ".cmd." > /dev/pts/2" | redraw!'
  execute 'silent execute "!".cmd." > /dev/pts/2" | redraw!'
  let g:last_rspec = cmd
endfunction

"CUSTOM COMMANDS
command! FF FufFile
command! BG call ToggleBackground()
command! S w !sudo tee %
command! P let @+= "rspec ".expand("%")
command! -nargs=* Spec call RunRspec(<args>)

"LAST SESSION
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim/sessions")) |
    \ call mkdir($HOME . "/.vim/sessions") |
    \ endif |
    \ execute "mksession! " . $HOME . "/.vim/sessions/default.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/sessions/default.vim") |
    \ execute "source " . $HOME . "/.vim/sessions/default.vim"

"CUSTOM TABS
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
    if getbufvar(bufnr, "&modified")
      let s.= (i == t ? '%#TabModFlagSel#' : '%#TabModFlag#')
    endif
    let s .= file
    let s .= ' '
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= '%=%#TabClose#%999XX'
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
highlight TabModFlagSel term=bold cterm=bold ctermfg=11 ctermbg=none


highlight TabLine term=underline ctermfg=16 ctermbg=0
highlight TabWinNum term=bold cterm=bold ctermfg=161 ctermbg=0
highlight TabNum term=bold cterm=bold ctermfg=166 ctermbg=0
highlight TabModFlag term=bold cterm=bold ctermfg=166 ctermbg=0

highlight TabClose term=bold cterm=bold ctermfg=11 ctermbg=none
