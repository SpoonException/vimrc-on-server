set nocompatible
let mapleader = ","

""""""""""""""""""""""""""""""
" => Load pathogen path
""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/nerdcommenter'    " 代码注释
Plug 'tomasr/molokai' " 颜色主题
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autochdir " 自动切换当前目录为当前文件所在的目录
set errorformat=%m\ in\ %f\ on\ line\ %l
set shell=/bin/zsh\ -l
set autoread
" set splitright                  " 新分割窗口在右边
" set splitbelow                  " 新分割窗口在下边
set helpheight=999              " 查看帮助文档全屏
" autocmd FocusGained,BufEnter * checktime

" 设置行号
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
set cursorline " 突出显示当前行


"-----------------------------------------------------------------
" 获取当前系统类型
"------------------------------------------------------------------
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler " 打开状态栏标尺

" Height of the command bar
set cmdheight=1 " 设定命令行的行数为 1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent  " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set smartcase

" Highlight search results
set hlsearch
" set nowrapscan " 禁止在搜索到文件两端时重新搜索

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb=   " 置空错误铃声的终端代码
" set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on " 自动语法高亮
syntax enable

" Enable 256 colors palette in Gnome Terminal
" if $COLORTERM == 'gnome-terminal'
" set t_Co=256
" endif
" 主题颜色设置
set t_Co=256

try
    colorscheme molokai
    " colorscheme desert
catch
endtry

set background=dark

set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 设置字体以及中文支持
if has("win32")
    set guifont=Inconsolata:h12:cANSI
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set tabstop=4   " 设定 tab 长度为 4 个空格
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格

" Linebreak on 500 characters
set lbr
set tw=500

set autoindent  " Auto indent
set smartindent " 开启新行时使用智能自动缩进
set wrap " Wrap lines

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
"nnoremap <C-w> <C-w>w
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tl :exe "tabn ".g:lasttab<cr>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    " set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2    " 显示状态栏 (默认值为 1, 无法显示状态栏)

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ " 设置在状态行显示的信息


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
" nnoremap <M-j> mz:m+<cr>`z
" nnoremap <M-k> mz:m-2<cr>`z
" vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" 颠倒行
nnoremap <Leader>j mz:m+<cr>`z
nnoremap <Leader>k mz:m-2<cr>`z
vnoremap <Leader>j :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <Leader>k :m'<-2<cr>`>my`<mzgv`yo`z


inoremap jk <esc>

cmap w!! w !sudo tee > /dev/null %
