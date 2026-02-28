" ============================================================================ "
"                                                                              "
" :++:   :++-   .+++=.                      :  -+-                             "
"  -@@:   =@@: -*++@@#                    +@-   @@:                            "
"   %@%    %@*     +@*                    @@:   @@:                            "
"   -@@:   -@@.    +@-:--   .--: --  --::-@@+:. @@: -=-       .-==. :::   :::. "
"    @@*    @@+    *@  #@* :==%@ +@#=+*..:%@=-  %@+==*@@:   :-==*@@. =@% -++*  "
"    *@@    #@%    %=   @@-   -# -@%      %@-   %@:   +@% .%*    @@-  =@%-     "
"    -@@-   #@@-   #    -@%   == -@%      %@=   @@:   -@@ +@+    @@-   +@#     "
"     %@#  *.#@*  =:     #@+  *  :@@      %@=   @@-   -@% +@%    @@-  .=*@#    "
"     :@@+*= :@@*=-      .@@+=+  :@@      %@=   *@#   **. .%@*.  @%. .*  +@%.  "
"      -##+   -*#+        .#%@   =##-.    :*#:   =#*=-.     -*#+-:  -#=   -##: "
"                           =-                                                 "
"                     =#   ++                                                  "
"                     -#%*#-                                                   "
"                                                                              "
" This configuration file is still very much in development, but it's usable.  "
" Has Windows file paths.                                                      "
" ============================================================================ "
" CONTENTS                                                          *contents* "
"                                                                              "
" 1. New Defaults ............................................. |new-defaults| "
"    1.1 GUI Language ......................................... |gui-language| "
"    1.2 Appearance ............................................. |appearance| "
"    1.3 Functionality ....................................... |functionality| "
"    1.4 Searching ............................................... |searching| "
"    1.5 Clipboard ............................................... |clipboard| "
"    1.6 GVIM Specifics ..................................... |gvim-specifics| "
"    1.7 Justify ................................................... |justify| "
"    1.8 NetRW Config ......................................... |netrw-config| "
" 2. Rebinds ....................................................... |rebinds| "
" 3. Plugins ....................................................... |plugins| "
" 4. Plugin Tweaks ........................................... |plugin-tweaks| "
"    4.1 Colourscheme ......................................... |colourscheme| "
"    4.2 Goyo ......................................................... |goyo| "
"    4.3 Pencil ..................................................... |pencil| "
"    4.4 Vim Table ............................................... |vim-table| "
"    4.5 Vim Startify ......................................... |vim-startify| "
"    4.6 Easy Align ............................................. |easy-align| "

language en_GB
set langmap=АБЦДЕФГХИЙКЛМНОПѪРСТУВѦЖЫЗ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,абцдефгхийклмнопѫрстувѧжыз;abcdefghijklmnopqrstuvwxyz
" This is so I can use my custom cyrillic keyboard to navigate around

"    1.2 Appearance                                               *appearance* "

set guifont=Inconsolata:h12 " Sets font
set linespace=0 " Sets the space between lines, if needed

"    1.3 Functionality                                         *functionality* "

filetype plugin on " Enables filetype detection
set nocompatible " Disables vi compatible mode
set hidden " Enables switching buffers without saving
set tw=0 " Makes it so line breaks don't create new lines
set linebreak " Makes it so line breaks don't cutoff words
set so=5 " Sets scrolloff (bottom and top margin)
set nostartofline " Prevents single line movement from being too stiff
set relativenumber number " Displays line numbers and their relative position to the current line
let mapleader = " " " Sets leader to the space key

" Open help files vertically
augroup vimrc_help
  autocmd!
  autocmd FileType help wincmd L
augroup END

" Swap, backup and undofile, make sure to change paths if not using Windows
set directory=~\vimfiles\Swap\
call mkdir(&directory, "p")
set backup
set backupdir=~\vimfiles\Backup\\
call mkdir(&backupdir, "p")
set undofile
set undodir=~\vimfiles\Undo
call mkdir(&undodir, "p")

"    1.4 Searching                                                 *searching* "

set ignorecase " Ignore cases when searching by default
set smartcase " Unless uppercase is used

"    1.5 Clipboard                                                 *clipboard* "

set clipboard=unnamed " Enables shared clipboard

"    1.6 GVIM Specifics                                       *gvim-specifics* "

set guioptions -=T " Hides the toolbar
set guioptions -=m " Hides the menubar
set guioptions -=r " Hides the right scrollbar
set guioptions -=L " Hides the left scrollbar
set guioptions -=b " Hides the bottom scrollbar
set columns=84 " Makes the default window size 84 characters wide
set lines=40 " Makes the default window size 40 characters tall

"    1.7 Text Justifying                                     *text-justifying* "

packadd! justify " Package used to justify text:
" 1. Use 'Vgq' or 'gqq' to break a single long line;
" 2. Then select the lines and use '_j' to justify;
" 3. To undo, select the lines and use Leader-J and 'J' to join them back together.
xnoremap <Leader>J :s/\s\+/ /g<CR>

"    1.8 NetRW Config                                           *netrw-config* "

let g:netrw_keepdir = 0 " Changes current directory when browsing
let g:netrw_winsize = 30 " Set to use 30% of screen
let g:netrw_banner = 0 " Disable banner
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " Hide hidden files
let g:netrw_localcopydircmd = 'cp -r' " Copy recursively
nnoremap <leader>dd :Lexplore %:p:h<CR>
" Opens netrw in the current file's directory with Leader-dd
nnoremap <Leader>da :Lexplore ~\Documents<CR>
" Opens netrw in the Documents folder with Leader-da
hi! link netrwMarkFile Search " Changes marked files highlight type

" Calls function only on netrw
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" Rebinds a lot of common NetRW keybinds to vim keys
function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR><C-w>h
  " Open preview with l
  nmap <buffer> L <CR>:Lexplore<CR>
  " Open and close netrw with L

  nmap <buffer> n %:w<CR>:buffer #<CR>
  " Create new file in current directory with n
  nmap <buffer> f mf
  " Select file with f
  nmap <buffer> . gh
  " Show hidden files with .

  nmap <buffer> P <C-w>z

  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

" ============================================================================ "
" 2. Rebinds                                                         *rebinds* "

" Centralise screen on every search
nnoremap n nzt
nnoremap N Nzt
nnoremap * *zt
nnoremap # #zt
nnoremap g* g*zt
nnoremap g# g#zt

" Remaps capital Y to copy the current line, without the line break at the end
nmap Y ^y$

" Movement keys work on single lines
noremap j gj
noremap k gk

" Change buffer with Tab / Shift-Tab, and close with Leader-q and Leader-Q
nnoremap <silent> <tab> :update<CR>:bnext<CR>
nnoremap <silent> <s-tab> :update<CR>:bprevious<CR>
nnoremap <silent> <Leader>q :update<CR>:bnext<CR>:bdelete #<CR>
nnoremap <silent> <Leader>Q :bnext<CR>:bdelete! #<CR>

" Create new file with Leader-n
nnoremap <Leader>n :enew<CR>

" Close all buffers and open a new one with Leader-N
nnoremap <Leader>N :%bd<CR>

" Toggle numbers with Leader-l
nnoremap <Leader>l :setlocal number! relativenumber!<CR>

" Toggle spellcheck with Leader-ss
nnoremap <Leader>ss :setlocal spell!<CR>

" Select word from spellchecker with Leader-sc and move with Leader-SC
nnoremap <leader>sc z=
nnoremap <leader>sC ]s

" Insert math expression result with Leader-c
nnoremap <Leader>c a<C-r>=

" Pasting doesn't store deleted text, only if used with Leader
xnoremap p "_dP
xnoremap P "_dp
nnoremap <Leader>p p
nnoremap <Leader>P P
xnoremap <Leader>p p
xnoremap <Leader>P P

" ============================================================================ "
" 3. Plugins                                                         *plugins* "

call plug#begin('C:\tools\vim\vim91\plugged')
" call plug#begin() # Uncomment this line if not using Windows

" Colourschemes

Plug 'https://gitlab.com/yorickpeterse/happy_hacking.vim.git'
Plug 'yorickpeterse/vim-paper'

" Writing Plugins

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'

" RST

Plug 'habamax/vim-rst'
Plug 'dhruvasagar/vim-table-mode'

" Functionalities

Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'https://github.com/lilydjwg/colorizer'

call plug#end()

" ============================================================================ "
" 4. Plugin Tweaks                                             *plugin-tweaks* "

"    4.1 Colourscheme                                          *colourschemes* "

colorscheme happy_hacking

"    4.2 Goyo                                                           *goyo* "

" Set custom Goyo widths
augroup GoyoWidths
  autocmd!
  autocmd FileType rst let g:goyo_width = 66
  autocmd FileType *   let g:goyo_width = 80
augroup END

" Open Goyo with Leader-g
nnoremap <Leader>g :Goyo<CR>

" Toggles numbers when entering Goyo
autocmd! User GoyoEnter setlocal nonumber norelativenumber
autocmd! User GoyoLeave setlocal number relativenumber

" autocmd! User GoyoEnter Limelight " Call Limelight automatically
" autocmd! User GoyoLeave Limelight!

"    4.3 Pencil                                                       *pencil* "

let g:pencil#wrapModeDefault = 'hard'
" Creates new lines instead of a long line
let g:pencil#autoformat = 1
" Auto wraps after textwidth
let g:pencil#textwidth = 66

" Call Pencil if editing a .rst file
augroup pencil
  autocmd!
autocmd FileType rst Pencil | setlocal spell spelllang=en_gb textwidth=66 wrap linebreak
augroup END

"    4.4 Vim Table                                                 *vim-table* "

" Sets table corners to RST standards
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

" Vim Table starts by typing three bars '|||'
inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

"    4.5 Vim Startify                                           *vim-startify* "

let g:startify_custom_header = 'startify#center(g:ascii)'

let g:ascii = [
\ ':++:   :++-   .+++=.                      :  -+-                           ',
\ '-@@:   =@@: -*++@@#                    +@-   @@:                           ',
\ ' %@%    %@*     +@*                    @@:   @@:                           ',
\ ' -@@:   -@@.    +@-:--   .--: --  --::-@@+:. @@: -=-       .-==. :::   :::.',
\ '  @@*    @@+    *@  #@* :==%@ +@#=+*..:%@=-  %@+==*@@:   :-==*@@. =@% -++* ',
\ '  *@@    #@%    %=   @@-   -# -@%      %@-   %@:   +@% .%*    @@-  =@%-    ',
\ '  -@@-   #@@-   #    -@%   == -@%      %@=   @@:   -@@ +@+    @@-   +@#    ',
\ '   %@#  *.#@*  =:     #@+  *  :@@      %@=   @@-   -@% +@%    @@-  .=*@#   ',
\ '   :@@+*= :@@*=-      .@@+=+  :@@      %@=   *@#   **. .%@*.  @%. .*  +@%. ',
\ '    -##+   -*#+        .#%@   =##-.    :*#:   =#*=-.     -*#+-:  -#=   -##:',
\ '                         =-                                                ',
\ '                   =#   ++                                                 ',
\ '                   -#%*#-                                                  ',
\ '                                                                           ',
\]

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   Most Recently Used'] },
        \ { 'type': 'sessions',  'header': ['   Sessions'] },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
        \ { 'type': 'commands',  'header': ['   Commands'] },
        \ ]

let g:startify_files_number = 6
let g:startify_custom_indices = ['1', '2', '3', '4', '5', '6']
let g:startify_session_delete_buffers = 1
let g:startify_padding_left = 4

let g:startify_bookmarks = [
\ { 'c': 'C:\tools\vim\_vimrc' },
\ ]

" Open Startify with Leader-Enter
nnoremap <Leader><CR> :Startify<CR>

" Session shortcuts
nnoremap <Leader>be :SLoad<CR>
nnoremap <Leader>bw :SSave<CR>
nnoremap <Leader>bd :SDelete<CR>
nnoremap <Leader>bq :SClose<CR>

"    4.6 Easy Align                                               *easy-align* "

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

