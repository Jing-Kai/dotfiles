"[ appearance ]
	set t_Co=256
	set background=dark
  colorscheme solarized
  let g:solarized_termtrans=1

"[ general ]
	set ruler
	set cursorline
	set hlsearch
  set nocompatible              " be iMproved, required
	set showcmd
	set autoread
	set showmatch
	set showmode
  set number
  " Enable mouse in all modes
  set mouse=a
  " Start scrolling three lines before the horizontal window border
	set scrolloff=3
	set history=50
  set shortmess=atI
	syntax on
  filetype off                  " required

"[ editing ]
	set textwidth=80
	set tabstop=2
	set shiftwidth=2
	set expandtab
	set autoindent
	set backspace=indent,eol,start
	set clipboard=unnamed

	let python_highlight_all = 1

" Centralize backups, swapfiles and undo history
  set backupdir=~/.vim/backups
  set directory=~/.vim/swaps
  if exists("&undodir")
    set undodir=~/.vim/undo
  endif

" Don’t create backups when editing files in certain directories
  set backupskip=/tmp/*,/private/tmp/*

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

"[ tabbing ]
	map <S-H> gT
	map <S-L> gt

"[ shortcut ]
	let mapleader=","
	let g:mapleader=","
	" set ,/ turn off the highlight search
	nmap <leader>/ :nohl<CR>
	" allow multiple indentation/dedentation in visual mode
	vnoremap < <gv
	vnoremap > >gv
	" :cd. change working directory to that of the current file
	cmap cd. lcd %:p:h
	nmap gf :tabedit <cfile><CR>
	" Quickly edit/reload the vimrc file
	nmap <silent> <leader>ev :e $MYVIMRC<CR>
	nmap <silent> <leader>sv :so $MYVIMRC<CR>
	" Quick to commadline
	nnoremap ; :
	nnoremap j gj
	nnoremap k gk
	nnoremap Y y$
	" Easy window nevigation
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
	nmap <silent> <leader>f :execute "vimgrep /" . expand("<cword>") . "/j *" <Bar> cw<CR>


"[ Bash like keys for the commadline ]
	" Bash like keys for the command line
	 cnoremap <C-A>      <Home>
	 cnoremap <C-E>      <End>
	 cnoremap <C-K>      <C-U>

"[ lintr ]
    "https://github.com/jimhester/lintr#editors-setup
    let g:syntastic_enable_r_lintr_checker = 1
    let g:syntastic_r_checkers = ['lintr']

    "Recommended settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%{FugitiveStatusline()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0


"[ status ]
	set laststatus=2

	set statusline=   " clear the statusline for when vimrc is reloaded
	set statusline+=%-3.3n\                      " buffer number
	set statusline+=%f\                          " file name
	set statusline+=%h%m%r%w                     " flags
	set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
	set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
	set statusline+=%{&fileformat}]              " file format
	set statusline+=%=                           " right align
	set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
	"set statusline+=%b,0x%-8B\                   " current char
	"set statusline+=%5*                          " apply User 5 color
   set statusline+=%{fugitive#statusline()}     " fugitive to show the git branch
	set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'wincent/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" Nerd Tree
Plugin 'scrooloose/nerdtree.git'
" Syntastic. Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'
" Nerd Tree plugin (git)
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Easy Motion
Plugin 'easymotion/vim-easymotion'
" vim-scala
Plugin 'derekwyatt/vim-scala'
" Surround
Plugin 'tpope/vim-surround'
" Python autoindent
Plugin 'vim-script/indentpython'
" Python YMC
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-script/Syntastic'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"[ reload configuration ]
function! UpdateVimRC()
     for server in split(serverlist())
         call remote_send(server, '<Esc>:source $HOME/.vimrc<CR>')
     endfor
 endfunction
 augroup myvimrchooks
 au!
    autocmd bufwritepost .vimrc call UpdateVimRC()
 augroup END

"[ plugin ]
	" Use pathogen to easily modify the runtime path to include all
	" plugins under the ~/.vim/bundle directory
    " call pathogen#helptags()
	" call pathogen#runtime_append_all_bundles()
	" Ominifunc
	autocmd FileType python runtime! autoload/pythoncomplete.vim

	" For easymotion: change the default <leader>
	let g:EasyMotion_leader_key = 'f'

	" For the color of Screen in terminal
	let vimrplugin_screenplugin = 0

"[ NERDTree setting ]
	nmap <leader>n :NERDTree<CR>
	let NERDTreeIgnore=['\.pyc$', '\.aux$', '.pdf$', ',log$', '\~$', '\.swp']

"[ TagBar setting ]
	nmap <F8> :TagbarToggle<CR>
