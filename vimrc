" ===== Declare Dependencies To Vundle =====
" Vundle needs to be before everything else, IDK why.
" Plugin configuration is at the bottom of the file
"
" :VundleInstall        - Installs any missing pulugins
" :VundleClean          - Remove unused plugins
" :VundleSearch ZoomWin - searches vimscripts for ZoomWin

set nocompatible                  " Behave more usefully at the expense of backwards compatibility (this line comes first b/c it alters how the others work)
filetype off                      " Don't run filetype callbacks while Vundle does its thing
set rtp+=~/.vim/bundle/Vundle.vim " Set the runtime path to include Vundle
call vundle#begin()               " Initialize Vundle

" Useful
Plugin 'https://github.com/gmarik/Vundle.vim'              " Let Vundle manage itself
Plugin 'https://github.com/scrooloose/nerdtree'            " Tree Display for the file system
Plugin 'https://github.com/Shougo/vimproc.vim'             " Runs tasks Asynchronously, it's a dependency of Unite.vim
Plugin 'https://github.com/Shougo/unite.vim'               " Searches through lists of things (files, buffers, etc)
Plugin 'https://github.com/tpope/vim-commentary'           " Easily comment/uncomment code
Plugin 'https://github.com/tpope/vim-endwise'              " Automatically inserts `end` for you. Convenient, works well, stays out of the way otherwise
Plugin 'https://github.com/tpope/vim-fugitive'             " Git integration... I should learn this better
Plugin 'https://github.com/bling/vim-airline'              " Status bar at the bottom of the screen
Plugin 'https://github.com/tpope/vim-repeat'               " Uhm, a dep of something, it lets you repeat non-atomic instructions with the dot. Unfortunately, too minimal, so not easy for me to use (I wish it would take over vim's shitty macro system)
Plugin 'https://github.com/tpope/vim-surround'             " Better support for working with things that 'surround' text such as quotes and parens

" Language Support
Plugin 'https://github.com/vim-ruby/vim-ruby'              " Ruby    - Pretty fkn legit (eg it's generally $LOAD_PATH aware, it's got some really awesome text objects)
Plugin 'https://github.com/pangloss/vim-javascript'        " JavaScript     - The humans have turned this language into something to respect
Plugin 'https://github.com/tpope/vim-markdown'             " Markdown - A plain text format for barely structured documents
Plugin 'https://github.com/dag/vim-fish'                   " Fish     - alternate shell

" Colorschemes (syntax highlighting, aka themes)
Plugin 'https://github.com/w0ng/vim-hybrid'

call vundle#end()            " required

"" ===== Smallest reasonable configuration =====
set nocompatible                " Behave more usefully at the expense of backwards compatibility (this line comes first b/c it alters how the others work)
set encoding=utf-8              " Format of the text in our files (prob not necessary, but should prevent weird errors)
filetype plugin on              " Load code that configures vim to work better with whatever we're editing
filetype indent on              " Load code that lets vim know when to indent our cursor
syntax on                       " Turn on syntax highlighting
set backspace=indent,eol,start  " backspace through everything in insert mode
set expandtab                   " When I press tab, insert spaces instead
set shiftwidth=2                " Specifically, insert 2 spaces
set tabstop=2                   " When displaying tabs already in the file, display them with a width of 2 spaces

"" ===== Instead of backing up files, just reload the buffer (in-memory representation of a file) when it changes. =====
"" Imma edit the same file multiple times, okay, vim? fkn deal
set autoread                         " Auto-reload buffers when file changed on disk
set nobackup                         " don't use backup files
set nowritebackup                    " don't backup the file while editing
set noswapfile                       " don't create swapfiles for new buffers
set updatecount=0                    " Don't try to write swapfiles after some number of updates
set backupskip=/tmp/*,/private/tmp/* " Can edit crontab files

"" ===== Aesthetics =====
set t_Co=256        " Explicitly tell vim that the terminal supports 256 colors (iTerm2 does, )
set background=dark " Tell vim to use colours that works with a dark terminal background (opposite is "light")
set laststatus=2    " Always show the statusline
set nowrap          " Display long lines as truncated instead of wrapped onto the next line
set cursorline      " Colour the line the cursor is on
set number          " Show line numbers
set hlsearch        " Highlight search matches

"" Basic behaviour =====
set scrolloff=4     " adds top/bottom buffer between cursor and window
set incsearch       " Incremental searching

"" ===== Mappings and keybindings. Note that <Leader> is the backslash by default. =====
" You can change it, though, as seen here: https://github.com/bling/minivimrc/blob/43d099cc351424c345da0224da83c73b75bce931/vimrc#L20-L21
cmap %/ <C-R>=expand("%:p:h")."/"<CR>;                    " Replace %/ with directory of current file (eg `:vs %/`)
cmap %% <C-R>=expand("%")<CR>;                            " Replace %% with current file (eg `:vs %%`)
vnoremap . :norm.<CR>;                                    " In visual mode, "." will for each line, go into normal mode and execute the "."
nnoremap <Leader>v :set paste<CR>"*p<CR>:set nopaste<CR>; " Paste without being stupid ("*p means to paste on next line (p) from the register (") that represents the clipboard (*))
nmap <Leader>p orequire "pry"<CR>binding.pry<ESC>;        " Pry insertion

"" ===== Seeing Is Believing =====
" Assumes you have a Ruby with SiB available in the PATH
nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
nmap <leader>n :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
nmap <leader>c :%!seeing_is_believing --clean<CR>;
nmap <leader>m A # => <Esc>;
vmap <leader>m :norm A # => <Esc>;


"" =====  easier navigation between split windows =====
" NOTATION:
"
" <C-h>  means "hold control and press 'h'",
"        so this first one means that when you hold control and press "h",
"        it will be as if you had held control and pressed "w",
"        then released control and pressed "h"
"
" <Esc>h means "Press Escape and then press 'h'".
"        Or if your terminal is configured to, you can hold option and press
"        "h". So this first one means that when you hold control and press "h",
"        it will be as if you had held control and pressed "w",
"        then released control and pressed "h"
nnoremap <c-h> <c-w>h; " Goes to the window to the left of this one.
nnoremap <c-j> <c-w>j; " Goes to the window under this one.
nnoremap <c-k> <c-w>k; " Goes to the window above this one.
nnoremap <c-l> <c-w>l; " Goes to the window to the right of this one.


"" ===== Shell keybindings for commandline mode  ======
"  http://tiswww.case.edu/php/chet/readline/readline.html#SEC4
"  many of these taken from vimacs http://www.vim.org/scripts/script.php?script_id=300

" navigation
  " Beginning of the line
    cnoremap <C-a> <Home>
  " End of the line
    cnoremap <C-e> <End>
  " Right 1 character
    cnoremap <C-f> <Right>
  " Left 1 character
    cnoremap <C-b> <Left>
  " Back 1 word
    cnoremap <Esc>b <S-Left>
  " Back a character
    cnoremap <Esc>f <S-Right>
  " Previous line
    cnoremap <Esc>p <Up>
  " Next line
    cnoremap <Esc>n <Down>

" editing
  " Kill right (basically "cut")
    cnoremap <C-k> <C-f>d$<C-c><End>
  " Yank what we killed (basically "paste")
    cnoremap <C-y> <C-r><C-o>
  " Delete next character
    cnoremap <C-d> <Right><C-h>


"" =====  Filetypes  ======
au BufRead,BufNewFile *.elm setfiletype haskell          " Highlight Elm as Haskell
au BufRead,BufNewFile *.sublime-* setfiletype javascript " Highlight sublime configuration files as javascript .sublime-{settings,keymap,menu,commands}
au BufRead,BufNewFile *.sublime-snippet setfiletype html " Highlight sublime templates as html

"" =====  Trailing Whitespace  =====
" Don't remember where I got this from
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces() " strip trailing whitespace on save

"" =====  Turn off arrow keys  =====
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap  <Up> <NOP>
noremap  <Down> <NOP>
noremap  <Left> <NOP>
noremap  <Right> <NOP>


" ===== Airline =====
set laststatus=2                                        " Always show the statusline
let g:airline#extensions#disable_rtp_load = 1           " don't autoload extensions
let g:airline_powerline_fonts             = 0           " no fancy separator charactors
let g:airline_left_sep                    = ''          " no fancy separator on LHS
let g:airline_right_sep                   = ''          " no fancy separator on RHS
let g:airline#extensions#branch#enabled   = 0           " don't show git branch
let g:airline_detect_modified             = 1           " marks when the file has changed
let g:airline_detect_paste                = 1           " enable paste detection (set paste) ie I'm not typing, I'm pasting, dammit, vim!
let g:airline_detect_iminsert             = 1           " I have no idea
let g:airline_inactive_collapse           = 1           " inactive windows should have the left section collapsed to only the filename of that buffer.
let g:airline_section_y                   = ''          " turn off file encoding
let g:airline_theme                       = 'bubblegum' " https://github.com/bling/vim-airline/wiki/Screenshots#bubblegum


" ===== NERDTree =====

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ===== Gruvbox for the Colorscheme =====
" Now switch to this custom colorscheme (dark gray)
colorscheme hybrid " slightly brighter than 'hybrid' theme

