"""  Pathogen Initialization
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

""" General Config
"runtime macros/matchit.vim
syntax on
set number
set nowrap
set mouse=a
set encoding=utf-8
set backupcopy=no
set nobackup
set tabpagemax=15

" only on WINDOWS
if has("win32")
  set runtimepath=~/.vim,$VIMRUNTIME
  set backspace=indent,eol,start whichwrap+=<,>,[,]
  imap <C-S-V> <ESC>"+gP
endif

""" Statusbar
set laststatus=2
set ruler
set showcmd

""" Indentation
set autoindent
set expandtab
filetype plugin indent on

autocmd FileType * set tabstop=2
autocmd FileType * set softtabstop=2
autocmd FileType * set shiftwidth=2

autocmd FileType python,java set tabstop=4
autocmd FileType python,java set tabstop=4
autocmd FileType python,java set softtabstop=4
autocmd FileType json set conceallevel=0

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Completion =======================
"
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore+=vendor/**
set wildignore +=*.log
set wildignore+=log/**
set wildignore+=*/log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore +=*/.git
set wildignore+=*.gem
set wildignore+=*.gemsspec
set wildignore+=*.sassc

let g:bg_flag = 0

""" custom functions
function! ShowBackground()
  let g:bg_flag = 1
  execute 'colorscheme '.tolower(g:colors_name)
endfunction

function! HideBackground()
  let g:bg_flag = 0
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr ctermbg=none
endfunction

function! ToggleBackground()
  if g:bg_flag == 0
    call ShowBackground()
  else
    call HideBackground()
  endif
endfunction

function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction

""" colors
set t_Co=256
set background=dark
colorscheme hybrid_material
call HideBackground()

""" search
set hlsearch
set incsearch

""" file types
autocmd BufRead,BufNewFile *spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *Spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.exbl  set filetype=ruby.html
autocmd BufRead,BufNewFile *.rxls  set filetype=ruby.html
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb
autocmd BufRead,BufNewFile *.ofx set filetype=xml

""" mapping
map <C-l> :let @/=""<CR>
map <F2> :NERDTreeTabsToggle<CR>
autocmd BufRead,BufNewFile *.xml map <F3> :.!xmllint --format --recover -<CR>
map <F4> xf 3xi:<ESC>
map <F5> :e<CR>
autocmd BufEnter,BufRead,BufNewFile *.haml map <S-F6> O- binding.pry<ESC>
autocmd BufEnter,BufRead,BufNewFile *.rb map <S-F6> Obinding.pry<ESC>
autocmd BufEnter,BufRead,BufNewFile *.js map <S-F6> Odebugger<ESC>
autocmd BufEnter,BufRead,BufNewFile *.py map <S-F6> Oimport pdb; pdb.set_trace()<ESC>

map <F7> :SyntasticCheck rubocop<CR>

map <F8> ve:s/_/ /g<CR><C-o><C-l>
map <F10> :tabe $MYVIMRC<CR>
map <F12> :call ToggleBackground()<CR>

map \* <S-*>:AckFromSearch! app<CR>
map \\* <S-*>:AckFromSearch! ../lib<CR>
map \@ :Ack! "(def (self.\|)\|class )<cword>"<CR>
map \\@ :Ack! "(class\|module) <cword>"<CR>
map \f :Ack!<Space>

map \c :%s///gn<CR>
map \l :let @+= "rspec ".GetSpecPath(). ":".line('.')<CR>
map \n :NERDTreeTabsToggle<CR>
map \r :let @+= "rspec ".GetSpecPath()<CR>
map \j :let @+= "mocha ".GetJsSpecPath()<CR>
map \, :BreakLineCommas<CR>

"copy, paste, delete
map \p "+p
map \y "+y
map \yy "+yy
map \yw "+yw
map \yb "+yb
vmap <C-x> "+d<CR>
vmap <C-c> "+y<CR>
imap <C-v> <ESC>"+p==<space>
imap <C-A> <ESC>ggvG$

"move line
nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv

map v$$ vg_
map cu ct_
map cU F_lct_

map <S-Insert> <MiddleMouse>
cmap w!! %!sudo tee > /dev/null %
cmap ww call WriteCreatingDirs()
cmap qq tabclose

"nerdcommenter
map \cc :call NERDComment(0, "toggle")<CR>
map \c<space> :call NERDComment(0, "comment")<CR>

"emmet
imap <c-j> <C-y>,

"rspec
function! RunRspec(args)
  let args = ''
  if a:args != ''
    let args .= ':'.a:args
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

function! GetSpecPath()
  let s = expand('%')

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'app/', 'spec/', '')
    let s = substitute(s, '.rb', '_spec.rb', '')
  endif

  return s
endfunction

function! GetJsSpecPath()
  let s = expand('%')
  return s
endfunction

""" folding
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
         " Create the fold from l_min to l
         execute l_min . "," . l . " fold"
      endif
   else
      " Delete the fold on the current line
      normal zd
   endif
endfunction

nmap <space> :call ToggleFold()<CR>
vmap <space> zf

"""
"ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<C-X>', '<C-S>'],
      \ 'AcceptSelection("e")': ['<C-R>', '<C-O>'],
      \ 'AcceptSelection("t")': ['<CR>', '<C-T>', '<2-LeftMouse>'],
      \ }
let g:ctrlp_root_markers = ['Gemfile', 'package.json']
let g:ctrlp_show_hidden = 1

"airline
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = '  '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':p:t'


command! FixHashSyntax call FixHashSyntax()

"windowswap
function! TooEasyWindowSwap()
  call WindowSwap#EasyWindowSwap()
  wincmd l
  call WindowSwap#EasyWindowSwap()
  wincmd h
endfunction
nnoremap <silent> <leader>wl :call TooEasyWindowSwap()<CR>

"vim-javascript
let javascript_enable_domhtmlcss=1

"vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"ack
"let g:ack_autoclose = 1

"nerdtree
let g:NERDTreeShowLineNumbers=1

"startify
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_list_order = [
      \ ['   Sessions:'],
      \ 'sessions',
      \ ['   My most recently used files:'],
      \ 'files',
      \ ['   My most recently used files in the current directory:'],
      \ 'dir',
      \ ['   Bbookmarks:'],
      \ 'bookmarks',
      \ ['   Commands:'],
      \ 'commands',
      \ ]

"ale
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby': ['rubocop'],
      \}
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s '
