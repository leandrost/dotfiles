"""  Pathogen Initialization
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

""" General Config
"runtime macros/matchit.vim
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

" workaround for https://github.com/vim/vim/issues/1start671
if has("unix")
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname == "Linux"
    set t_BE=
  endif
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
set wildignore+=*.log
set wildignore+=log/**
set wildignore+=*/log/**
set wildignore+=*tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*/.git
set wildignore+=*.gem
set wildignore+=*.gemsspec
set wildignore+=*.sassc
set wildignore+=*/node_modules/*

""" search
set hlsearch
set incsearch

""" file types
autocmd BufRead,BufNewFile *spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *Spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.exbl  set filetype=ruby.html
autocmd BufRead,BufNewFile *.rxls  set filetype=ruby.html
autocmd BufRead,BufNewFile *.rabl  set filetype=ruby
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb
autocmd BufRead,BufNewFile *.ofx set filetype=xml
autocmd BufRead,BufNewFile .envrc set filetype=sh
autocmd BufRead,BufNewFile *.reek set filetype=yaml

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
map <F9> :source $MYVIMRC<CR>
map <F10> :tabe $MYVIMRC<CR>
map <C-F10> :tabe ~/.vim<CR>
map <F12> :call theme#ToggleBackground()<CR>

nmap <space> :call folding#ToggleFold()<CR>
vmap <space> zf

map \* <S-*>:AckFromSearch!<CR>
map \\* <S-*>:AckFromSearch! ../lib<CR>
map \@ :Ack! "def\s.*<cword>"<CR>
map \\@ :Ack! "(class\|module) <cword>"<CR>
map \f :Ack!<Space>

map \c :%s///gn<CR>
map \l :let @+= "rspec ".GetSpecPath(). ":".line('.')<CR>
map \ffl :let @+= "rspec ".GetSpecPath(). ":".line('.'). " --fail-fast"<CR>
map \ff :let @+= "rspec ".GetSpecPath(). " --fail-fast"<CR>
map \n :NERDTreeToggle<CR>
map \r :let @+= "rspec ".GetSpecPath()<CR>
map \j :let @+= "mocha ".GetJsSpecPath()<CR>
map \, :BreakLineCommas<CR>
map \" :s/'/"/g<CR>
map \' :s/"/'/g<CR>
map \% :lcd %:p:h<CR>
map \\n :NERDTree %:p:h<CR>
map \o :only<CR>
map \i :ALENext<CR>
map \\i :ALEPrevious<CR>
map \. :b#<CR>

abbr todo: <esc>:call AddTodo()<CR>

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
cmap ww call utils#WriteCreatingDir()
cmap qq tabclose

"nerdcommenter
map \cc :call NERDComment(0, "toggle")<CR>
map \c<space> :call NERDComment(0, "comment")<CR>
let NERDSpaceDelims=1
let NERDDefaultAlign = 'left'

"emmet
imap <c-j> <C-y>,
vmap \e <C-y>,

""" "ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<C-X>', '<C-S>'],
      \ 'AcceptSelection("e")': ['<C-R>', '<C-O>'],
      \ 'AcceptSelection("t")': ['<CR>', '<C-T>', '<2-LeftMouse>'],
      \ }
let g:ctrlp_root_markers = ['Gemfile', 'package.json']
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\vendor$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"airline
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1

let g:airline#extensions#tabline#enabled = 0
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

function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction

function! AddTodo()
    let branch_name = system('printf $(git rev-parse --abbrev-ref HEAD)')
    execute 'normal! i @todo '.branch_name.' -'
    startinsert!
endfunction

function! OpenTabToNewSpec()
  let current_file_name = expand('%:r')
  let file_name = substitute(current_file_name, 'app', 'spec', '')
  execute 'tabedit '.file_name.'_spec.rb'
endfunction
cmap AA call OpenTabToNewSpec()

" Replaces regular assignments `a = 1` with let `let(:a) { 1 }` in normal mode
fun! LettifyAssignment()
  :s/\(\w*\)\s=\s\(.*\_$\)/let(:\1) { \2 }/g
endfun
" Calls `LettifyAssignment` for entire visual selection
fun! LettifyAssignments() range
  :call LettifyAssignment()
endfun
nnoremap \\let :call LettifyAssignment()<cr>
vnoremap <Leader>let :call LettifyAssignments()<cr>

"vim-javascript
let javascript_enable_domhtmlcss=1

"vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"ack
let g:ack_autoclose = 1
let g:ackprg = 'ag --vimgrep'

"nerdtree
let g:NERDTreeShowLineNumbers=1
let g:loaded_nerdtree_custom_maps = 1

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
      \   'ruby': ['rubocop', 'reek'],
      \}
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s '
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_change_sign_column_color=1
