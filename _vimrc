set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/vimfiles/bundle/Vundle.vim
let path='~/vimfiles/bundle'
call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"Bundle "pangloss/vim-javascript"
Bundle 'vim-scripts/The-NERD-tree'
"Foramt in one button press
Bundle 'Chiel92/vim-autoformat'
"Syntax check
Bundle 'scrooloose/syntastic'
"Bundle 'xolox/vim-session'

call vundle#config#require(g:bundles)

"set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"Windows like behavior
source $VIMRUNTIME/mswin.vim
behave mswin

"Misc setup without plugin required

"Colors
colorscheme desert
set guifont=Consolas:h11:cDEFAULT

"Window Splits
"rather than ctr+w + <movement> just to ctr+movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"get rid of swp and ~ files
set backupdir=$HOME\\vimtemp\\
set directory=$HOME\\vimtemp\\
set noundofile
silent execute '!del "'.$VIMRUNTIME.'\temp\*~"'

"Tabs
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab

"Synatx Highlighting and Validation
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

"Trim trailing space in python on save
autocmd BufWritePre *.py :%s/\s\+$//e
"Remove ^M on save
"autocmd BufWritePre *.js :%s/
"//g
"autocmd BufWritePre *.html :%s/
"//g


"JS Beautify on save, didn't work so do f3
"autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin

"NerdTree
map <leader>n :NERDTreeToggle<CR>

"Autoformat
noremap <F3> :Autoformat<CR><CR>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '"' . $VIMRUNTIME . '\diff"'
      let eq = '""'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

