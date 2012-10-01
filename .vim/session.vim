let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =snipMate#BackwardsSnippet()
inoremap <Plug>(fakeclip-screen-insert-p) =fakeclip#content('pastebuffer')
noremap! <Plug>(fakeclip-screen-insert-o) =fakeclip#content('pastebuffer')
noremap! <Plug>(fakeclip-screen-insert-r) =fakeclip#content('pastebuffer')
noremap! <Plug>(fakeclip-screen-insert) =fakeclip#content('pastebuffer')
inoremap <Plug>(fakeclip-insert-p) =fakeclip#content('clipboard')
noremap! <Plug>(fakeclip-insert-o) =fakeclip#content('clipboard')
noremap! <Plug>(fakeclip-insert-r) =fakeclip#content('clipboard')
noremap! <Plug>(fakeclip-insert) =fakeclip#content('clipboard')
inoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)a
inoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)a
inoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()a
inoremap <Plug>ZenCodingSplitJoinTagInsert :call zencoding#splitJoinTag()
inoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()a
inoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()a
inoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
inoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
inoremap <Plug>ZenCodingBalanceTagOutwardInsert :call zencoding#balanceTag(-1)
inoremap <Plug>ZenCodingBalanceTagInwardInsert :call zencoding#balanceTag(1)
inoremap <Plug>ZenCodingExpandWord u:call zencoding#expandAbbr(1,"")a
inoremap <Plug>ZenCodingExpandAbbr u:call zencoding#expandAbbr(0,"")a
nmap  <Plug>ZenCodingExpandNormal
vmap  <Plug>ZenCodingExpandVisual
xnoremap 	 s:let g:snipmate_content_visual=getreg( 1 )
snoremap <silent> 	 i<Right>=snipMate#TriggerSnippet()
vmap <NL> :m'>+gv=gv
nmap <NL> :m+==
vmap  :m-2gv=gv
nmap  :m-2==
map  :let @/=""
snoremap  b<BS>
vmap c <Plug>ZenCodingCodePretty
nmap A <Plug>ZenCodingAnchorizeSummary
nmap a <Plug>ZenCodingAnchorizeURL
nmap k <Plug>ZenCodingRemoveTag
nmap j <Plug>ZenCodingSplitJoinTagNormal
vmap m <Plug>ZenCodingMergeLines
nmap / <Plug>ZenCodingToggleComment
nmap i <Plug>ZenCodingImageSize
nmap N <Plug>ZenCodingPrev
nmap n <Plug>ZenCodingNext
vmap D <Plug>ZenCodingBalanceTagOutwardVisual
nmap D <Plug>ZenCodingBalanceTagOutwardNormal
vmap d <Plug>ZenCodingBalanceTagInwardVisual
nmap d <Plug>ZenCodingBalanceTagInwardNormal
nmap , <Plug>ZenCodingExpandWord
vmap "&D <Plug>(fakeclip-screen-D)
nmap "&D <Plug>(fakeclip-screen-D)
nmap "&dd <Plug>(fakeclip-screen-dd)
vmap "&d <Plug>(fakeclip-screen-d)
nmap "&d <Plug>(fakeclip-screen-d)
vmap "&[P <Plug>(fakeclip-screen-[P)
vmap "&[p <Plug>(fakeclip-screen-[p)
vmap "&]P <Plug>(fakeclip-screen-]P)
vmap "&]p <Plug>(fakeclip-screen-]p)
vmap "&gP <Plug>(fakeclip-screen-gP)
vmap "&gp <Plug>(fakeclip-screen-gp)
vmap "&P <Plug>(fakeclip-screen-P)
vmap "&p <Plug>(fakeclip-screen-p)
nmap "&[P <Plug>(fakeclip-screen-[P)
nmap "&[p <Plug>(fakeclip-screen-[p)
nmap "&]P <Plug>(fakeclip-screen-]P)
nmap "&]p <Plug>(fakeclip-screen-]p)
nmap "&gP <Plug>(fakeclip-screen-gP)
nmap "&gp <Plug>(fakeclip-screen-gp)
nmap "&P <Plug>(fakeclip-screen-P)
nmap "&p <Plug>(fakeclip-screen-p)
vmap "&Y <Plug>(fakeclip-screen-Y)
vmap "&y <Plug>(fakeclip-screen-y)
nmap "&yy <Plug>(fakeclip-screen-Y)
nmap "&Y <Plug>(fakeclip-screen-Y)
nmap "&y <Plug>(fakeclip-screen-y)
snoremap % b<BS>%
snoremap ' b<BS>'
snoremap U b<BS>U
snoremap \ b<BS>\
map \yb "+yb
map \yw "+yw
map \yy "+yy
map \y "+y
map \p "+p
snoremap ^ b<BS>^
snoremap ` b<BS>`
nmap gx <Plug>NetrwBrowseX
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=snipMate#BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
vnoremap <silent> <Plug>(fakeclip-screen-D) :call fakeclip#delete('pastebuffer', 'V')
nnoremap <silent> <Plug>(fakeclip-screen-D) :set operatorfunc=fakeclip#pastebuffer_deleteg@$
nnoremap <silent> <Plug>(fakeclip-screen-dd) :set operatorfunc=fakeclip#pastebuffer_deleteg@g@
vnoremap <silent> <Plug>(fakeclip-screen-d) :call fakeclip#delete('pastebuffer', visualmode())
nnoremap <silent> <Plug>(fakeclip-screen-d) :set operatorfunc=fakeclip#pastebuffer_deleteg@
vnoremap <silent> <Plug>(fakeclip-screen-[P) :call fakeclip#put('pastebuffer', visualmode(), '[P')
vnoremap <silent> <Plug>(fakeclip-screen-[p) :call fakeclip#put('pastebuffer', visualmode(), '[p')
vnoremap <silent> <Plug>(fakeclip-screen-]P) :call fakeclip#put('pastebuffer', visualmode(), ']P')
vnoremap <silent> <Plug>(fakeclip-screen-]p) :call fakeclip#put('pastebuffer', visualmode(), ']p')
vnoremap <silent> <Plug>(fakeclip-screen-gP) :call fakeclip#put('pastebuffer', visualmode(), 'gP')
vnoremap <silent> <Plug>(fakeclip-screen-gp) :call fakeclip#put('pastebuffer', visualmode(), 'gp')
vnoremap <silent> <Plug>(fakeclip-screen-P) :call fakeclip#put('pastebuffer', visualmode(), 'P')
vnoremap <silent> <Plug>(fakeclip-screen-p) :call fakeclip#put('pastebuffer', visualmode(), 'p')
nnoremap <silent> <Plug>(fakeclip-screen-[P) :call fakeclip#put('pastebuffer', '', '[P')
nnoremap <silent> <Plug>(fakeclip-screen-[p) :call fakeclip#put('pastebuffer', '', '[p')
nnoremap <silent> <Plug>(fakeclip-screen-]P) :call fakeclip#put('pastebuffer', '', ']P')
nnoremap <silent> <Plug>(fakeclip-screen-]p) :call fakeclip#put('pastebuffer', '', ']p')
nnoremap <silent> <Plug>(fakeclip-screen-gP) :call fakeclip#put('pastebuffer', '', 'gP')
nnoremap <silent> <Plug>(fakeclip-screen-gp) :call fakeclip#put('pastebuffer', '', 'gp')
nnoremap <silent> <Plug>(fakeclip-screen-P) :call fakeclip#put('pastebuffer', '', 'P')
nnoremap <silent> <Plug>(fakeclip-screen-p) :call fakeclip#put('pastebuffer', '', 'p')
vnoremap <silent> <Plug>(fakeclip-screen-Y) :call fakeclip#yank('pastebuffer', 'V')
nnoremap <silent> <Plug>(fakeclip-screen-Y) :call fakeclip#yank_Y('pastebuffer')
vnoremap <silent> <Plug>(fakeclip-screen-y) :call fakeclip#yank('pastebuffer', visualmode())
nnoremap <silent> <Plug>(fakeclip-screen-y) :set operatorfunc=fakeclip#pastebuffer_yankg@
vnoremap <silent> <Plug>(fakeclip-D) :call fakeclip#delete('clipboard', 'V')
nnoremap <silent> <Plug>(fakeclip-D) :set operatorfunc=fakeclip#clipboard_deleteg@$
nnoremap <silent> <Plug>(fakeclip-dd) :set operatorfunc=fakeclip#clipboard_deleteg@g@
vnoremap <silent> <Plug>(fakeclip-d) :call fakeclip#delete('clipboard', visualmode())
nnoremap <silent> <Plug>(fakeclip-d) :set operatorfunc=fakeclip#clipboard_deleteg@
vnoremap <silent> <Plug>(fakeclip-[P) :call fakeclip#put('clipboard', visualmode(), '[P')
vnoremap <silent> <Plug>(fakeclip-[p) :call fakeclip#put('clipboard', visualmode(), '[p')
vnoremap <silent> <Plug>(fakeclip-]P) :call fakeclip#put('clipboard', visualmode(), ']P')
vnoremap <silent> <Plug>(fakeclip-]p) :call fakeclip#put('clipboard', visualmode(), ']p')
vnoremap <silent> <Plug>(fakeclip-gP) :call fakeclip#put('clipboard', visualmode(), 'gP')
vnoremap <silent> <Plug>(fakeclip-gp) :call fakeclip#put('clipboard', visualmode(), 'gp')
vnoremap <silent> <Plug>(fakeclip-P) :call fakeclip#put('clipboard', visualmode(), 'P')
vnoremap <silent> <Plug>(fakeclip-p) :call fakeclip#put('clipboard', visualmode(), 'p')
nnoremap <silent> <Plug>(fakeclip-[P) :call fakeclip#put('clipboard', '', '[P')
nnoremap <silent> <Plug>(fakeclip-[p) :call fakeclip#put('clipboard', '', '[p')
nnoremap <silent> <Plug>(fakeclip-]P) :call fakeclip#put('clipboard', '', ']P')
nnoremap <silent> <Plug>(fakeclip-]p) :call fakeclip#put('clipboard', '', ']p')
nnoremap <silent> <Plug>(fakeclip-gP) :call fakeclip#put('clipboard', '', 'gP')
nnoremap <silent> <Plug>(fakeclip-gp) :call fakeclip#put('clipboard', '', 'gp')
nnoremap <silent> <Plug>(fakeclip-P) :call fakeclip#put('clipboard', '', 'P')
nnoremap <silent> <Plug>(fakeclip-p) :call fakeclip#put('clipboard', '', 'p')
vnoremap <silent> <Plug>(fakeclip-Y) :call fakeclip#yank('clipboard', 'V')
nnoremap <silent> <Plug>(fakeclip-Y) :call fakeclip#yank_Y('clipboard')
vnoremap <silent> <Plug>(fakeclip-y) :call fakeclip#yank('clipboard', visualmode())
nnoremap <silent> <Plug>(fakeclip-y) :set operatorfunc=fakeclip#clipboard_yankg@
vnoremap <Plug>ZenCodingCodePretty :call zencoding#codePretty()
nnoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)
nnoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)
nnoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()
nnoremap <Plug>ZenCodingSplitJoinTagNormal :call zencoding#splitJoinTag()
vnoremap <Plug>ZenCodingMergeLines :call zencoding#mergeLines()
nnoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()
nnoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()
nnoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
nnoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
vnoremap <Plug>ZenCodingBalanceTagOutwardVisual :call zencoding#balanceTag(-2)
nnoremap <Plug>ZenCodingBalanceTagOutwardNormal :call zencoding#balanceTag(-1)
vnoremap <Plug>ZenCodingBalanceTagInwardVisual :call zencoding#balanceTag(2)
nnoremap <Plug>ZenCodingBalanceTagInwardNormal :call zencoding#balanceTag(1)
nnoremap <Plug>ZenCodingExpandWord :call zencoding#expandAbbr(1,"")
nnoremap <Plug>ZenCodingExpandNormal :call zencoding#expandAbbr(3,"")
vnoremap <Plug>ZenCodingExpandVisual :call zencoding#expandAbbr(2,"")
map <F4> :!xmllint --format --recover -
map <F3> :set nopaste
map <F2> :set paste
imap  <Plug>ZenCodingExpandAbbr
inoremap <silent> 	 u=snipMate#TriggerSnippet()
inoremap <silent> 	 =snipMate#ShowAvailableSnips()
imap & <Plug>(fakeclip-screen-insert-p)
map! & <Plug>(fakeclip-screen-insert-o)
map! & <Plug>(fakeclip-screen-insert-r)
map! & <Plug>(fakeclip-screen-insert)
imap A <Plug>ZenCodingAnchorizeSummary
imap a <Plug>ZenCodingAnchorizeURL
imap k <Plug>ZenCodingRemoveTag
imap j <Plug>ZenCodingSplitJoinTagInsert
imap / <Plug>ZenCodingToggleComment
imap i <Plug>ZenCodingImageSize
imap N <Plug>ZenCodingPrev
imap n <Plug>ZenCodingNext
imap D <Plug>ZenCodingBalanceTagOutwardInsert
imap d <Plug>ZenCodingBalanceTagInwardInsert
imap ; <Plug>ZenCodingExpandWord
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=indent,eol,start
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=50
set hlsearch
set incsearch
set laststatus=2
set mouse=a
set ruler
set runtimepath=~/.vim,~/.vim/bundle/FuzzyFinder,~/.vim/bundle/L9,~/.vim/bundle/ZenCoding.vim,~/.vim/bundle/jellybeans.vim,~/.vim/bundle/nerdtree,~/.vim/bundle/snipmate-snippets,~/.vim/bundle/tlib_vim,~/.vim/bundle/vim-addon-mw-utils,~/.vim/bundle/vim-fakeclip,~/.vim/bundle/vim-rails,~/.vim/bundle/vim-snipmate,~/.vim/bundle/zencoding-vim,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,~/.vim/bundle/vim-snipmate/after,~/.vim/after
set shiftwidth=2
set showcmd
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabline=%!MyTabLine()
set tabpagemax=15
set tabstop=2
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/myfinance/src
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +115 ~/.bashrc
badd +27 ~/.certman
badd +107 ~/.vimrc
badd +1 app/controllers/bank_slip_configurations_controller.rb
args ~/.bashrc
edit app/controllers/bank_slip_configurations_controller.rb
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
nnoremap <buffer> <silent> g} :exe        "ptjump =RubyCursorIdentifier()"
nnoremap <buffer> <silent> } :exe          "ptag =RubyCursorIdentifier()"
nnoremap <buffer> <silent> g] :exe      "stselect =RubyCursorIdentifier()"
nnoremap <buffer> <silent> g :exe        "stjump =RubyCursorIdentifier()"
nnoremap <buffer> <silent>  :exe v:count1."stag =RubyCursorIdentifier()"
nnoremap <buffer> <silent> ] :exe v:count1."stag =RubyCursorIdentifier()"
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nnoremap <buffer> <silent>  :exe  v:count1."tag =RubyCursorIdentifier()"
nnoremap <buffer> <silent> g] :exe       "tselect =RubyCursorIdentifier()"
nnoremap <buffer> <silent> g :exe         "tjump =RubyCursorIdentifier()"
nmap <buffer> gf <Plug>RailsFind
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/projects/myfinance/src,~/projects/myfinance/src/app,~/projects/myfinance/src/app/models,~/projects/myfinance/src/app/controllers,~/projects/myfinance/src/app/helpers,~/projects/myfinance/src/config,~/projects/myfinance/src/lib,~/projects/myfinance/src/app/views,~/projects/myfinance/src/app/views/bank_slip_configurations,~/projects/myfinance/src/public,~/projects/myfinance/src/test,~/projects/myfinance/src/test/unit,~/projects/myfinance/src/test/functional,~/projects/myfinance/src/test/integration,~/projects/myfinance/src/spec,~/projects/myfinance/src/spec/models,~/projects/myfinance/src/spec/controllers,~/projects/myfinance/src/spec/helpers,~/projects/myfinance/src/spec/views,~/projects/myfinance/src/spec/lib,~/projects/myfinance/src/spec/requests,~/projects/myfinance/src/spec/integration,~/projects/myfinance/src/app/*,~/projects/myfinance/src/vendor,~/projects/myfinance/src/vendor/plugins/*/lib,~/projects/myfinance/src/vendor/plugins/*/test,~/projects/myfinance/src/vendor/rails/*/lib,~/projects/myfinance/src/vendor/rails/*/test,NOTE:\\\ Gem.all_load_paths\\\ is\\\ deprecated\\\ with\\\ no\\\ replacement.\\\ It\\\ will\\\ be\\\ removed\\\ on\\\ or\\\ after\\\ 2011-10-01.\
Gem.all_load_paths\\\ called\\\ from\\\ -e:1.\
NOTE:\\\ Gem.all_partials\\\ is\\\ deprecated\\\ with\\\ no\\\ replacement.\\\ It\\\ will\\\ be\\\ removed\\\ on\\\ or\\\ after\\\ 2011-10-01.\
Gem.all_partials\\\ called\\\ from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:260.\
/home/leandrost/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:261:in\\\ `block\\\ (2\\\ levels)\\\ in\\\ all_load_paths':\\\ undefined\\\ method\\\ `add'\\\ for\\\ \"/home/leandrost/.rvm/gems/ruby-1.9.3-p125-perf@myfinance\":String\\\ (NoMethodError)\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:429:in\\\ `block\\\ (2\\\ levels)\\\ in\\\ each_load_path'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:428:in\\\ `each'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:428:in\\\ `block\\\ in\\\ each_load_path'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:423:in\\\ `each'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:423:in\\\ `each_load_path'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:260:in\\\ `block\\\ in\\\ all_load_paths'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:259:in\\\ `each'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems.rb:259:in\\\ `all_load_paths'\
\	from\\\ ~/.rvm/rubies/ruby-1.9.3-p125-perf/lib/ruby/site_ruby/1.9.1/rubygems/deprecate.rb:63:in\\\ `block\\\ (2\\\ levels)\\\ in\\\ deprecate'\
\	from\\\ -e:1:in\\\ `<main>'\

setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.slim
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=~/projects/myfinance/src/tmp/tags,./tags,./TAGS,tags,TAGS,~/projects/myfinance/src/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
