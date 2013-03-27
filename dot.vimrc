set nocompatible               " be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
" let NeoBundle manage NeoBundle
" required!
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc の clone 後、以下のコマンドを実行する必要がある。
" $ cd $HOME/.vim/bundle/vimproc
" $ make -f make_mac.mak
" $ ln -s $HOME/.vim/bundle/vimproc/autoload/proc.so $HOME/.vim/autoload
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'rails.vim'
NeoBundle 'kchmck/vim-coffee-script'

filetype plugin indent on
let g:Aline_xstrlen = 3
set number
set nocompatible
syntax on

"--------------------------------------
" 全般
"--------------------------------------

let mapleader = ";"

":qをCtrl+qでできるように
map <C-Q> <ESC>:q<CR>
imap <C-Q> <ESC>:q<CR>

" Ctrl+s で保存
"imap <C-s> <Esc>:w<CR>

" 保存時に行末の空白文字を消す
function! RTrim()
  let s:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", s:cursor)
endfunction

autocmd BufWritePre * call RTrim()

" 改行コードの自動認識
set fileformats=unix,dos,mac
" Macのvimでbackspaceを有効にする
set backspace=2
"Vi互換をオフ
set nocompatible
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"タブ文字、行末など不可視文字を表示する
set lcs=tab:>.,trail:_,extends:\
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/
set list
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"インクリメンタルサーチを行う
set incsearch

"タイムスタンプ
nmap <F5> <ESC>o----------<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR>----------<CR>
nmap <F6> <ESC>i<C-R>=strftime("%a %b %d %H:%M:%S %Y  Nobuyuki Honda  <honda@netlab.jp>")<CR><CR>
"nmap <F6> <ESC>I<C-R>=strftime("%Y-%m-%d %H:%M:%S ")<ESC>

au Filetype ruby			 nnoremap <buffer><leader>e :!ruby %<Space>
au Filetype javascript nnoremap <buffer><leader>e :!js %<Space>
au Filetype vim				 nnoremap <silent><leader>e :source %<Return>

map <C-U> <C-Y>2<C-Y>2<C-Y>2<C-Y>2<C-Y><C-Y>
map <C-D> <C-E>2<C-E>2<C-E>2<C-E>2<C-E><C-E>

" F12 で次のバッファを表示
map <silent> <F12> :bn!<CR>
" F11 で前のバッファを表示
map <silent> <F11> :bp!<CR>
" Ctrl+Lでバッファリストを表示
map <C-L> :ls<CR>
" F8でバッファ削除
map <silent> <F8> :bd<CR>
" F10 で次のウィンドウリストを表示
map <F10> :cn!<CR>
" F9 で前のウィンドウリストを表示
map <F9> :cp!<CR>
" 編集中のファイルをsudo権限で上書き
map <F1> :w sudo:%<CR>

" 検索語が画面の中央にくるようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

map <F2> :IncBufSwitch<CR>

" format.vim
let format_join_spaces = 2
let format_allow_over_tw = 0

" vimfiler
let g:vimfiler_as_default_explorer=1

"-------------------------------------------------------------------------------
" vim-unite
"-------------------------------------------------------------------------------

""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイルのヒストリー
nnoremap <silent> <leader>uh :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" 様々なショートカット
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
if has('win32') || has('win64')
 call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
 call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
else
 call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
endif

" yank履歴を\gyで扱える
let g:unite_source_history_yank_enable =1 "history/yankの有効化
nnoremap <silent>uy :<C-u>Unite history/yank<CR>

" /Volumeが無視されていたので追記
let g:unite_source_file_mru_ignore_pattern = '\~$\|\.\%(o\|exe\|dll\|bak\|sw[po]\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)\|^\%(\\\\\|/mnt/\|/media/\)'

" より便利に
nmap <SPACE>h <SPACE>t<leader>uh
nmap <SPACE>f <SPACE>t<leader>uf

"--------------------------------------------------------------------
" sudo.vim
" https://github.com/vim-scripts/sudo.vim
"--------------------------------------------------------------------
map <leader>su :e sudo:%<CR>

"--------------------------------------
" 検索関係
"--------------------------------------

" コマンド、検索パターンを10000個まで記憶
set history=10000
" 検索時に大文字小文字を区別しない
" set ignorecase
" 検索時に大文字が含まれていたら区別して検索
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan

"--------------------------------------
" 表示関係
"--------------------------------------
" タイトルをウィンドウ枠に表示する
set title
" ルーラーを表示
set ruler
" カッコ入力時に対応するカッコを表示
set showmatch
" コマンドライン補完を拡張モードにする
set wildmenu
" 検索結果文字列のハイライトを有効にする
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ステータスラインを常に表示
set laststatus=2

"--------------------------------------
" インデント
"--------------------------------------

" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入する時に、代わりに空白を使う
set expandtab

"--------------------------------------
" Ruby関連
"--------------------------------------

" rails.vim
let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="sqlite3"

function! RemoveRubyEval() range
  let begv = a:firstline
  let endv = a:lastline
  normal Hmt
  set lz
  execute ":" . begv . "," . endv . 's/\s*# \(=>\|!!\).*$//e'
  normal 'tzt`s
  set nolz
  redraw
endfunction


" Rubyではオムニ補完を無効にする
let g:AutoComplPop_BehaviorRubyOmniMethodLength="-1"
let g:AutoComplPop_BehaviorRubyOmniSymbolLength="-1"

"Rubyのオムニ補完を設定(ft-ruby-omni)
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

function! Ruby_eval_vsplit() range
  let src = tempname()
  let dst = "RubyOutput"
  " put current buffer's content in a temp file
  silent execute ": " . a:firstline . "," . a:lastline . "w " . src
  " open the preview window
  silent execute ":pedit! " . dst
  " change to preview window
  wincmd P
  " set options
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal syntax=none
  setlocal bufhidden=delete
  " replace current buffer with ruby's output
  silent execute ":%! ruby " . src . " 2>&1 "
  " change back to the source buffer
  wincmd p
endfunction

autocmd FileType ruby vmap <silent> <C-J> :call Ruby_eval_vsplit()<cr>
autocmd FileType ruby nmap <silent> <C-J> mzggVG<C-J>`z

"--------------------------------------------------
" 文字コードの自動認識
"--------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
