call pathogen#infect()

runtime macros/matchit.vim

syntax on
set encoding=utf-8
set nowrap

filetype plugin indent on
set autoindent
set expandtab

if has("win32")
  set runtimepath=~/.vim,$VIMRUNTIME
  set backspace=indent,eol,start whichwrap+=<,>,[,]
  imap <C-S-V> <ESC>"+gP
endif

autocmd FileType * set tabstop=2 
autocmd FileType * set softtabstop=2
autocmd FileType * set shiftwidth=2

autocmd FileType python,java set tabstop=4 
autocmd FileType python,java set tabstop=4 
autocmd FileType python,java set softtabstop=4

autocmd VimLeave * nested call SaveSession()
autocmd VimEnter * nested call LoadSession()

set t_Co=256
set background=dark
colorscheme solarized
highlight rubydefine ctermbg=none

set number
set hlsearch
set incsearch

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none

set laststatus=2

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

"ZEN CODING
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
map <F2> :NERDTreeToggle<CR>
map <F3> :%!xmllint --encode UTF-8 --format -<CR>
map <F6> Obinding.pry<ESC>
map <F5> :e<CR>

"COPY, PASTE, DELETE
map \p "+p
vmap <C-x> "+d<CR>
vmap <C-c> "+y<CR>
imap <C-v> <ESC>"+p==<space>

map \y "+y
map \yy "+yy
map \yw "+yw
map \yb "+yb


"MOVE LINE
nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv

map v$$ vg_
map cu ct_
map cU F_lct_

map <S-Insert> <MiddleMouse>
cmap w!! %!sudo tee > /dev/null %
cmap :q tabclose

"RSPEC
map \r :let @+= "rspec ".GetSpecPath()<CR>
map \l :let @+= "rspec ".GetSpecPath(). " -l ".line('.')<CR>

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

"LAST SESSION
let g:sessions_dir = $HOME."/.vim/sessions/"
let g:default_session = g:sessions_dir."default.vim"
let g:myfinance_session = g:sessions_dir."myfinance.vim"

function! SaveSession()
  if !isdirectory(g:sessions_dir)
    call mkdir(g:sessions_dir)
  endif
  if getcwd() == $HOME."/projects/myfinance/src"
    execute "mksession! ".g:myfinance_session
  else
    execute "mksession! ".g:default_session
  endif
endfunction

function! LoadSession()
  if argc() == 0 
    if getcwd() == $HOME."/projects/myfinance/src" && filereadable(g:myfinance_session)
      execute "source ".g:myfinance_session
    elseif filereadable(g:default_session)
      execute "source ".g:default_session
    endif
  endif
endfunction

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
  let s .= '%=%#TabClose#%999X X'

  highlight TabLineSel term=bold cterm=bold ctermfg=252 ctermbg=none
  highlight TabWinNumSel term=bold cterm=bold ctermfg=11 ctermbg=none
  highlight TabNumSel term=bold cterm=bold ctermfg=226 ctermbg=none
  highlight TabModFlagSel term=bold cterm=bold ctermfg=208 ctermbg=none

  highlight TabLineFill cterm=none 
  highlight TabLine cterm=none 

  highlight TabClose term=bold cterm=none ctermfg=255 ctermbg=none

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])

endfunction

set tabline=%!MyTabLine()
set tabpagemax=15

"good tab completion - press <tab> to autocomplete if there's a character
"previously
function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<c-p>"
      endif
endfunction

"CUSTOM FOLD
vmap <space> zf

function! ToggleFold()
   if foldlevel('.') == 0
      " No fold exists at the current line,
      " so create a fold based on indentation

      let l_min = line('.')   " the current line number
      let l_max = line('$')   " the last line number
      let i_min = indent('.') " the indentation of the current line
      let l = l_min + 1

      " Search downward for the last line whose indentation > i_min
      while l <= l_max
         " if this line is not blank ...
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            if indent(l) <= i_min

               " we've gone too far
               let l = l - 1    " backtrack one line
               break
            endif
         endif
         let l = l + 1
      endwhile

      " Clamp l to the last line
      if l > l_max
         let l = l_max
      endif

      " Backtrack to the last non-blank line
      while l > l_min
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            break
         endif
         let l = l - 1
      endwhile

      "execute "normal i" . l_min . "," . l . " fold"   " print debug info

      if l > l_min
"         " Create the fold from l_min to l
         execute l_min . "," . l . " fold"
      endif
   else
      " Delete the fold on the current line
      normal zd
   endif
endfunction

nmap <space> :call ToggleFold()<CR>

function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command W call WriteCreatingDirs()

function! GetSpecPath()
  let s = expand('%')

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'app/', 'spec/', '') 
    let s = substitute(s, '.rb', '_spec.rb', '') 
  endif

  return s
endfunction
