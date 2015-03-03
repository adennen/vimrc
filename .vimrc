" Make vim awesome

" Tabs and indenting 
set expandtab           " tabs into spaces
set tabstop=4           " 4 spaces to be exact
set shiftwidth=4        " amount for autoindent
set softtabstop=4       " deletes spaces in increments of 4 

set autoindent          " copy indentation from previous line
set smartindent         " changes indentation level based on braces (does not depend on filetype)
"filetype plugin indent on " too complex?

set noerrorbells visualbell t_vb=   " disable error sound

set backspace=indent,eol,start   " allow to delete current indent, join lines, delete past insert point
set showmatch  " Show matching parenthesis
set incsearch  " Search while typing

" Statusline
set laststatus=2
set statusline=%t%m%r%h%w\ [Format\ %{&ff}]\ [Type\ %Y]\ [%l,%v][%p%%]\ %{strftime(\"%m/%d/%y\ -\ %H:%M\")}

" Compile commands
map <f5>  :w<CR>:!if make %<; then ./%<; fi;<CR>
"map <f6>  :w<CR>:!if make %<; then ./%<; else make %< 2>&1 >/dev/null | less -d; fi;<CR>
map <f10> :w<CR>:!python %<CR>
map <f11> :w<CR>:!if gcc %; then ./a.out; rm a.out; fi;<CR>
map <f12> :w<CR>:!if g++ %; then ./a.out; rm a.out; fi;<CR>

" Code folding 
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

set foldcolumn=1        "add a clickable fold column

" Color scheme
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  colorscheme molokai
endif

" GUI options
set guioptions-=T
set guioptions-=t
set guifont=DejaVu\ Sans\ Mono\ 8
set sessionoptions+=resize,winpos

" General options
autocmd filetype asm set syntax=asm68k  " Set asm files to be asm68k by default 
set ignorecase       " smartcase requires ignorecase to be set
set smartcase
"set autochdir        " does not work with VimFiler
set backupdir=~/.vim/backup//   " Put annoying backup files here
set directory=~/.vim/swp//
"set hidden          " enable hidden buffers so that saving is optional
if has("gui_running")
   set lines=60 columns=124
endif


" Map Control-S to save from any mode
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>li
"imap <c-s> <Esc><c-s>

" Map Alt-O to open
nmap <a-o> :browse confirm e<CR>

" Tags
set tags=./tags;/             " Look for tags files up the directory tree
" Custom tags files
set tags+=~/.vim/tags/tags.libc6 


" F4: Add a fortune and advance to the next one
" mX			mark where we arme
" :sp ~/.fortunes<CR>	open a window on ~/.fortunes
" gg			go to first line
" d/^--/<CR>		delete until the next line starting with "--"
" Gp			Go to the end and put the just deleted text there
" :wq<CR>		Write the ~/.fortunes file and close the window
" 'XG			Go to the last line of the original file
" A<CR><Esc>		Add an empty line
" p			put the fortune text
" `X			return to where we started

" TODO: Broken, fix or do something with this
map <F4> mX:sp ~/.fortunes<CR>ggd/^--/<CR>Gp:wq<CR>'XGA<CR><Esc>p`X


" ------- Vundle stuff below -------
" // To install type :PluginInstall or :PluginInstall! to update.
" // :PluginClean to delete. :PluginSearch will find valid plugins
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" VimFiler required plugins
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'

" Taglist
Plugin 'Tagbar'

call vundle#end()            " required
filetype plugin indent on    " required
" --------


" VimFiler default appearance
"autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit

nmap <c-e> :VimFiler -split -simple -toggle -winwidth=30 -no-quit<CR>


" Make VimFiler behave like NERDTree. e.g. Expand folder on double click, edit on double click
" It would be nice if this could be reduced further
autocmd FileType vimfiler nmap <buffer><silent> <2-LeftMouse> :call <SID>vimfiler_on_double_click()<CR>
function! s:vimfiler_on_double_click() "{{{
  execute "normal " . vimfiler#smart_cursor_map(
            \ "\<Plug>(vimfiler_expand_tree)",
            \ "\<Plug>(vimfiler_edit_file)"
            \ ) 
endfunction"}}}

" VimFiler style
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▷'


" Tagbar shortcut
let g:tagbar_left = 1 " Show on the left side
let g:tagbar_sort = 0 " Set the default sort to unsorted
let g:tagbar_compact = 1 " Compact mode
autocmd VimEnter * nested :call tagbar#autoopen(1) " Open on startup
nnoremap <silent> <F8> :TagbarToggle<CR>

" formatoptions must be set after compatible is set
" Disable automatic comment continuations
autocmd FileType * setlocal formatoptions-=r formatoptions-=o
