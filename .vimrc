" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

function! s:init()

  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))

  NeoBundleFetch 'Shougo/neobundle.vim'

  " My Bundles here:
  NeoBundle 'Align'
  NeoBundle 'alpaca-tc/vim-endwise.git'
  NeoBundle 'Lokaltog/vim-powerline'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'mattn/gist-vim'
  NeoBundle 'osyo-manga/vim-over'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'Shougo/neocomplcache.vim'
  NeoBundle 'cohama/lexima.vim'
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'vim-jp/vimdoc-ja'

  call neobundle#end()

  filetype plugin indent on

  NeoBundleCheck
  "eslintでのチェック用
let g:syntastic_javascript_checkers=['eslint']
" エラー行に sign を表示
 let g:syntastic_enable_signs = 1
" " location list を常に更新
 let g:syntastic_always_populate_loc_list = 0
" " location list を常に表示
 let g:syntastic_auto_loc_list = 0
" " ファイルを開いた時にチェックを実行する
 let g:syntastic_check_on_open = 1
" " :wq で終了する時もチェックする
 let g:syntastic_check_on_wq = 0

"------------------------------------
"" gist-vim
"------------------------------------
"" gist

 let g:github_user  = 'n17001@std.it-college.ac.jp'
 let g:github_token = ''

"------------------------------------
" Align
"------------------------------------
" Alignを日本語環境で使用するための設定
  let g:Align_xstrlen = 3

"------------------------------------
" neocomplcache（自動補完）を有効化
"------------------------------------

  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  "<C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

"------------------------------------
" Vim-over
"------------------------------------
" over.vim の　呼び出し
  nnoremap <silent> <Leader>m :OverCommandLine<CR>
" カーソル下の単語をハイライト付きで置換
  nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
  nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>


endfunction

function! s:basic()

  syntax on

"------------------------------------
" Encode
"------------------------------------
  set fileformats=unix,dos,mac " 改行コード
  set encoding=utf-8 " デフォルトエンコーディング
  set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc  " ワイルドカードで表示するときに優先度を低くする拡張子

"------------------------------------
" Basic
"------------------------------------
  let mapleader="," " <Leader>キー
  set scrolloff=5 " スクロール時の余白確保
  set textwidth=0 " 自動で折り返しをしない
  set autoread " 自動読み直し
  set hidden " 編集中でも他のファイルを開けるようにする
  set backspace=indent,eol,start "バックスペースキーで削除できるものを指定
  set formatoptions=lmoq "テキスト整形オプション，マルチバイト系を追加
  set vb t_vb= " ビープ音を鳴らさない
  set browsedir=buffer " Exploreの初期ディレクトリ
  "set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
  set showcmd " コマンドをステータス行に表示
  set showmode " 現在のモードを表示
  set modelines=0 " モードラインは無効
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge
  "set virtualedit=all ""カーソルがどこでも移動できる

"------------------------------------
" Show
"------------------------------------
  set title " タイトルを表示する
  set ruler " ルーラーを表示
  set laststatus=2 " 常にステータラスラインを表示
  set showmatch " 対応する括弧をハイライト
 "set number " 行番号表示
 " set list " 不可視文字表示
  set listchars=extends:<

  " 全角スペースの表示
  highlight ZenkakuSpace cterm=underline ctermfg=red guibg=darkgray
  match ZenkakuSpace /　/
  set cursorline " カーソル行をハイライト
  set ttyfast " 高速ターミナル接続を行う

  " buftabs（常にバッファ番号を表示）の設定
  let bufrabs_only_basename = 1
  let buftabs_in_statusline = 1

"------------------------------------
" Indent
"------------------------------------
  set autoindent  " 自動でインデント
  set smartindent " 新しい行のインデントを現在行と同じ数に

"------------------------------------
" Search
"------------------------------------
  set incsearch " インクリメンタルサーチ
  set ignorecase " 大文字小文字無視
  set smartcase " 大文字は区別する
  set hlsearch " 検索文字をハイライト
  nmap \q :nohlsearch<CR>

"------------------------------------
" Helpfile
"------------------------------------

  set runtimepath+=~/.vim/bundle/vimdoc-ja
  set helplang=ja,en " 日本語ヘルプ

"------------------------------------
" Backup
"------------------------------------
  set nobackup " バックアップなし
  set noswapfile " スワップファイルを作らない

endfunction

function! s:keymap()

"------------------------------------
" Window
"------------------------------------
  nnoremap sh <C-w>h
  nnoremap sj <C-w>j
  nnoremap sk <C-w>k
  nnoremap sl <C-w>l
  nnoremap sH <C-w>H
  nnoremap sJ <C-w>J
  nnoremap sK <C-w>K
  nnoremap sL <C-w>L

" height
  nnoremap + <C-w>+
  nnoremap - <C-w>-
" width
  nnoremap ) <C-w>>
  nnoremap ( <C-w><LT>

" 日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

"------------------------------------
" Other
"------------------------------------
" .vimrcを編集するためのKey-mappingを定義
  nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>

  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  nnoremap <silent> [b :bprevious<CR>
  nnoremap <silent> ]b :bnext<CR>
  nnoremap <silent> [B :bfirst<CR>
  nnoremap <silent> ]B :blast<CR>

" Insert Mode での移動

  inoremap <C-e> <END>
  inoremap <C-a> <HOME>
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>
  "inoremap <silent> jj <ESC>
  "inoremap <silent> <C-j> <esc>


" 0, 9で行頭、行末へ
  nmap a ^
  nmap e $

" ビジュアルモード時vで行末まで選択
  vnoremap v $h


endfunction

function! s:folding_settings()
"------------------------------------
" folding
"------------------------------------
  set foldenable
  set foldmethod=syntax
  set foldopen=block,hor,mark,percent,quickfix,search,tag,undo
  set foldlevel=0
  set foldnestmax=2
  set foldcolumn=2

endfunction

function! s:main()
  call s:init()
  call s:basic()
  call s:keymap()
 " call s:folding_settings()
endfunction


call s:main()

"自分で設定
set cursorcolumn
" タブを表示するときの幅
 set tabstop=2
" " タブを挿入するときの幅
 set shiftwidth=2
" " タブをタブとして扱う(スペースに展開しない)
 set noexpandtab
" "
 set softtabstop=0
  "図形文字が崩れるのを防止
 set ambiwidth=double
 "ペースト時自動インデント無し
 "esc時半角英数にする
function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-c> <ESC>:call ImInActivate()<CR>
" インサートモード時ペーストモード解除
autocmd InsertLeave * set nopaste
"vimrcを自動読み込み
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END
"F3押した時ハイライト解除
nnoremap <F3> :noh<CR>
