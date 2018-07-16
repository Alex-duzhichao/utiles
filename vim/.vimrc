set nocompatible        " Must be first line

"maybe debug option
"set verbose=15

" Identify platform
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction

if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

" Basics
if !WINDOWS()
    set shell=/bin/sh
endif

"------------------------------------------------------------------------------------------------
"join path
function! PathJoin(...)
  if a:0 == 0 | return '' | endif
  let sp = '/'
  if g:iswindows
    if exists('+shellslash')
      let sp = (&shellslash ? '/' : '\')
    endif
  endif
  return join(a:000, sp)
endfunction

" Windows Compatible
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if WINDOWS()
    set runtimepath=$VIMRUNTIME,$HOME/.vim,$HOME/.vim/vim-plug,$HOME/.vim/plugged
    let g:vim_path = 'C:\Users\alexzcdu\.vim'
    let g:ctags_bin  = PathJoin(g:vim_path, 'bin', 'ctags')
    let g:cscope_bin = PathJoin(g:vim_path, 'bin', 'cscope')
    let g:astyle_bin = PathJoin(g:vim_path, 'bin', 'astyle')
    let g:log_file = PathJoin(g:vim_path, 'vim.log')
    let g:debug_log = 0
    
    let g:python_path = 'C:\ProgramData\chocolatey\lib\python3\tools'
    let g:python_bin = PathJoin(g:python_path, 'python')

    let g:cygwin_path = 'C:\tools\cygwin\bin'
    let g:mintty_bin = PathJoin(g:cygwin_path, 'mintty.exe')
    let g:find_bin = PathJoin(g:cygwin_path, 'find')

    let g:chrome_bin = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'

    " let g:zip_out_path = 'C:\Users\alexzcdu\Desktop\zip_file'
    let g:zip_out_path = 'C:\Program Files\CMake\bin'
endif

" Arrow Key Fix
" https://github.com/spf13/spf13-vim/issues/780
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb2312,gb18030,big5,euc-jp,euc-kr,latin1
set fileformat=unix

"gui options
if LINUX() && has("gui_running")
    set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
elseif OSX() && has("gui_running")
    set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
elseif WINDOWS() && has("gui_running")
    set guifont=Andale_Mono:h14,Menlo:h14,Consolas:h14,Courier_New:h14
endif

set lines=40                " 40 lines of text instead of 24
" General
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

" On mac and Windows, use * register for copy-paste
set clipboard=unnamed

au GUIEnter * simalt ~x "maximum the initial window
set background=dark     " Assume a dark background
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=i  "remove left-hand scroll bar
set belloff=all
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
set completeopt+=preview  "For insert mode completion
set autoread
" Automatically write a file when leaving a modified buffer
"Vim has a setting called autowrite that writes the content of the file automatically if you call :make.
set autowrite
" set cursorcolumn
set nocursorcolumn
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
" set nocursorcolumn
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear CursorLineNr    " Remove highlight color from current line number

" Use bundles config
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
color solarized             " Load a colorscheme

" Always switch to the current file directory
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Setting up the directories {
set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" To disable views add the following to your .vimrc.before.local file:

" Add exclusions to mkview and loadview
" eg: *.*, svn-commit.tmp
let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]


set ruler                   " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd                 " Show partial commands in status line and
" Selected characters/lines in visual mode
set laststatus=2

" Broken down into easily includeable segments
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=\ [%{getcwd()}]          " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" set foldenable                  " Auto fold code
set nofoldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


" Formatting {
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars

" Strip whitespace
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    %s/\r$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd FileType c,cpp,go,javascript,python,xml,yml,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType * if &modifiable|setlocal fileformat=unix|endif
autocmd FileType yml setlocal expandtab shiftwidth=2 softtabstop=2
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
" autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

" autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" Workaround vim-commentary for Haskell
" autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
" autocmd FileType haskell,rust setlocal nospell

" }

" End/Start of line motion keys act relative to row/wrap width in the
" presence of `:set wrap`, and relative to line for `:set nowrap`.
function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
        let vis_sel="gv"
    endif
    if &wrap
        execute "normal!" vis_sel . "g" . a:key
    else
        execute "normal!" vis_sel . a:key
    endif
endfunction

" Map g* keys in Normal, Operator-pending, and Visual+select
noremap $ :call WrapRelativeMotion("$")<CR>
noremap <End> :call WrapRelativeMotion("$")<CR>
noremap 0 :call WrapRelativeMotion("0")<CR>
noremap <Home> :call WrapRelativeMotion("0")<CR>
noremap ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap $ v:call WrapRelativeMotion("$")<CR>
onoremap <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensure the correct vis_sel flag is passed to function
vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" The following two lines conflict with moving to top and
" bottom of the screen
" map <S-H> gT
" map <S-L> gt

" Stupid shift key fixes
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

let mapleader = ';'

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier formatting
" markdown 有用
nnoremap <silent> <leader>q gwip

" FIXME: Revert this f70be548
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
" wmctrl is for linux
" map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }

" TextObj Sentence {
augroup textobj_sentence
    autocmd!
    autocmd FileType markdown call textobj#sentence#init()
    autocmd FileType textfile call textobj#sentence#init()
    autocmd FileType text call textobj#sentence#init()
augroup END
" TextObj Quote {
augroup textobj_quote
    autocmd!
    autocmd FileType markdown call textobj#quote#init()
    autocmd FileType textile call textobj#quote#init()
    autocmd FileType text call textobj#quote#init({'educate': 0})
augroup END

" autocmd BufEnter * echom "BufEnter"
" Functions {
" Initialize directories {
function! InitializeDirectories()
    let dir_list = {
                \ 'vimbackup': 'backupdir',
                \ 'vimviews': 'viewdir',
                \ 'vimswap': 'directory',
                \ 'vimundo': 'undodir' }

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories
    let common_dir = g:vim_path

    for [dirname, settingname] in items(dir_list)
        let directory = PathJoin(common_dir, dirname)
        if !isdirectory(directory)
            call mkdir(directory)
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

" Initialize NERDTree as needed
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction


" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
command! -complete=file -nargs=+ Shell call misc#RunCommandInWindow(<q-args>)

"------------------------ local ---------------------------------
" Don't indent namespace and template
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction
autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()


"------------------------------------------------------------------------------------------------
"for multi_cursors
function! Multiple_cursors_before()
    " exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    " exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
" g:multi_cursor_exit_from_visual_mode = 0
" g:multi_cursor_exit_from_insert_mode = 0

"------------------------------------------------------------------------------------------------
"for jump to begin
" nnoremap [[ [{
" nnoremap [{ [[
" nnoremap ]] ]}
" nnoremap ]} ]]

"------------------------------------------------------------------------------------------------
"for signify
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 0
let g:signify_disable_by_default = 1

highlight clear SignColumn      " SignColumn should match background

"------------------------------------------------------------------------------------------------
"for ctrlsf
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_position = 'bottom'
" let g:ctrlsf_debug_mode = 1
nmap <a-g> <Plug>CtrlSFCwordExec
nmap <s-f> <Plug>CtrlSFPrompt


"------------------------------------------------------------------------------------------------
"for mark
let g:mwDefaultHighlightingPalette = 'extended'
" let g:mwDefaultHighlightingPalette = 'maximum'
" let g:mwDefaultHighlightingNum = 9


"------------------------------------------------------------------------------------------------
"for EasyMotion
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map  \ <Plug>(easymotion-sn)
omap \ <Plug>(easymotion-tn)
" Move to word
map  f <Plug>(easymotion-bd-w)
nmap f <Plug>(easymotion-overwin-w)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" nmap <Leader><leader>s <Plug>(easymotion-s2)
" nmap <Leader><leader>c <Plug>(easymotion-t2)
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
" Move to line
" map e <Plug>(easymotion-bd-jk)
" nmap e <Plug>(easymotion-overwin-line)
" map f <Plug>(easymotion-lineforward)
" nmap f <Plug>(easymotion-lineforward)

"------------------------------------------------------------------------------------------------
" for capitalize
" gcw        - capitalize word (from cursor position to end of word)
" gcW        - capitalize WORD (from cursor position to end of WORD)
" gciw       - capitalize inner word (from start to end)
" gciW       - capitalize inner WORD (from start to end)
" gcis       - capitalize inner sentence
" gc$        - capitalize until end of line (from cursor postition)
" gcgc       - capitalize whole line (from start to end)
" gcc        - capitalize whole line
" {Visual}gc - capitalize highlighted text
" nnoremap gcw guw~h
"nnoremap gcW guW~h
"nnoremap gciw guiw~h
"nnoremap gciW guiW~h
"nnoremap gcis guis~h
"nnoremap gc$ gu$~h
"nnoremap gcgc guu~h
"nnoremap gcc guu~h
"vnoremap gc gu~h


function! SwitchCurrentWordCase(case)
    let l = line(".")
    let c = col(".")
    if(a:case == 'upper')
        normal viwU
    elseif(a:case == 'lower')
        normal viwu
    else
        normal viw~
    endif

    call cursor(l, c)
endfunction

"switch case of current word
nnoremap guw :call SwitchCurrentWordCase("upper") <cr>
nnoremap gUw :call SwitchCurrentWordCase("lower") <cr>
nnoremap g~w :call SwitchCurrentWordCase("~") <cr>

" for nerdCommenter
let g:NERDSpaceDelims=1

"------------------------------------------------------------------------------------------------
"for go
let g:go_fmt_autosave = 0


"------------------------------------------------------------------------------------------------
"for git 
" nnoremap <silent> <leader>gs :Gstatus<CR>
" nnoremap <leader>gc :call GitCommit("1.") <left><left><left>
" nnoremap <silent> <leader>gu :Git push<CR>
" nnoremap <silent> <leader>gp :Git pull<CR>
" nnoremap <leader>gm :call GitCheckout('master')<CR>
" nnoremap <silent> <leader>gd :call GitCheckout('dev')<CR>


"------------------------------------------------------------------------------------------------
"for syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs=1


"------------------------------------------------------------------------------------------------
"for a.vim
nnoremap <A-a> :A<cr>
nnoremap <A-p> :AV<cr>
nnoremap <A-m> :AS<cr>
" nnoremap <A-a> :A<cr>
" imap <Leader>ih <ESC>:IH<CR>
" nmap <Leader>ih :IH<CR>
" imap <Leader>is <ESC>:IH<CR>:A<CR>
" nmap <Leader>is :IH<CR>:A<CR>
" imap <Leader>sih <ESC>:IHS<CR>
" nmap <Leader>sih :IHS<CR>
" imap <Leader>sis <ESC>:IHS<CR>:A<CR>
" nmap <Leader>sis :IHS<CR>:A<CR>
" imap <Leader>vih <ESC>:IHV<CR>
" nmap <Leader>vih :IHV<CR>
" imap <Leader>vis <ESC>:IHV<CR>:A<CR>
" nmap <Leader>vis :IHV<CR>:A<CR>

"------------------------------------------------------------------------------------------------
" for vim-php-namespace
" inoremap <Leader>pu <C-O>:call PhpInsertUse()<CR>
" noremap <Leader>pu :call PhpInsertUse()<CR>
" inoremap <Leader>pe <C-O>:call PhpExpandClass()<CR>
" noremap <Leader>pe :call PhpExpandClass()<CR>
"------------------------------------------------------------------------------------------------
"for funky
" let g:ctrlp_root_markers = ['g:ProjPath']
nnoremap <A-f> :CtrlPFunky<Cr>
let g:ctrlp_by_filename = 1
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]boost$'
" let g:ctrlp_custom_ignore = {
            " \ 'dir': '\vboost$'
            " \ }
" narrow the list down with a word under cursor
" nnoremap <A-y> :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"------------------------------------------------------------------------------------------------
"for find keyword
" Map <Leader>fl to display all lines with keyword under cursor
" and ask which one to jump to
nmap <silent> <leader>fl [I:let nr = input("Which one: ")<Bar>if nr != "" <bar>silent! exec "silent normal " . nr ."[\t"<bar>endif<CR>
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


"------------------------------------------------------------------------------------------------
" for cscope map
" The following maps all invoke one of the following cscope search types:
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
nmap <leader>a :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <leader>w :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <leader>x :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>	
nmap <leader>e :cs find e 
nmap ti :cs find f <C-R>=expand("<cfile>")<CR><CR>	
" nmap <leader>tt :cs find t <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>te :cs find e <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

nmap <leader>sa :scs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <leader>sw :scs find g <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>sc :scs find c <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>stt :scs find t <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>ste :scs find e <C-R>=expand("<cword>")<CR><CR>	
" nmap <leader>sff :scs find f <C-R>=expand("<cfile>")<CR><CR>	
" nmap <leader>si :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
" nmap <leader>sd :scs find d <C-R>=expand("<cword>")<CR><CR>	

nmap <leader>va :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>vw :vert scs find g <C-R>=expand("<cword>")<CR><CR>
" nmap <leader>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
" nmap <leader>vtt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
" nmap <leader>vte :vert scs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <leader>vff :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
" nmap <leader>vi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
" nmap <leader>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"------------------------------------------------------------------------------------------------
"for matchit
let b:match_ignorecase = 1

"------------------------------------------------------------------------------------------------
"for NERDTree and tagbar
"t: Open the selected file in a new tab
" i: Open the selected file in a horizontal split window
" s: Open the selected file in a vertical split window
" I: Toggle hidden files
" m: Show the NERD Tree menu
" R: Refresh the tree, useful if files change outside of Vim
" ?: Toggle NERD Tree's quick help
" autocmd VimEnter * NERDTree
" autocmd VimEnter * NERDTree | wincmd p
let g:NERDShutUp=1
let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden=1
let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_Display_Tag_Scope=0
let Tlist_Compact_Format = 1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '^NTUSER*', '^ntuser*']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
let g:tagbar_left=1
let g:tagbar_width = 30
" autocmd VimEnter * nested :call tagbar#autoopen(1)
" autocmd VimEnter * nested :TagbarOpen
let g:tagbar_ctags_bin = g:ctags_bin

"------------------------------------------------------------------------------------------------
" Tabularize {
nmap <Leader>t& :Tabularize /&<CR>
vmap <Leader>t& :Tabularize /&<CR>
nmap <Leader>t= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>t= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>t=> :Tabularize /=><CR>
vmap <Leader>t=> :Tabularize /=><CR>
nmap <Leader>t: :Tabularize /:<CR>
vmap <Leader>t: :Tabularize /:<CR>
nmap <Leader>t" :Tabularize /"<CR>
vmap <Leader>t" :Tabularize /"<CR>
nmap <Leader>t:: :Tabularize /:\zs<CR>
vmap <Leader>t:: :Tabularize /:\zs<CR>
nmap <Leader>t, :Tabularize /,<CR>
vmap <Leader>t, :Tabularize /,<CR>
nmap <Leader>t,, :Tabularize /,\zs<CR>
vmap <Leader>t,, :Tabularize /,\zs<CR>
nmap <Leader>t// :Tabularize ////<CR>
vmap <Leader>t// :Tabularize ////<CR>
nmap <Leader>t; :Tabularize /;<CR>
vmap <Leader>t; :Tabularize /;<CR>
nmap <Leader>t<Bar> :Tabularize /<Bar><CR>
vmap <Leader>t<Bar> :Tabularize /<Bar><CR>
nmap <Leader>t<space> :Tabularize /<space><CR>
vmap <Leader>t<space> :Tabularize /<space><CR>


" JSON {
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" PyMode {
" Disable if python support not present
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_rope = 0

" ctrlp {
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <A-e> :CtrlP<CR>
nnoremap <silent> <A-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

if WINDOWS()
    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif
if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
endif
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ },
            \ 'fallback': s:ctrlp_fallback
            \ }

" CtrlP extensions
let g:ctrlp_extensions = ['funky','mixed']

"funky
" nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
" nnoremap <Leader>ff :execute 'CtrlPFunky ' . expand('<cword>')<Cr>


" Fugitive {
nnoremap <silent> <leader>gs :Gstatus<CR>
" nnoremap <silent> <leader>gd :Gdiff<CR>
" " nnoremap <silent> <leader>gc :Gcommit<CR>
" nnoremap <leader>gc :Git add -p %<CR> <bar> :Gcommit -a -m "1." <left><left>
nnoremap <leader>gc :Gcommit -a -m "1." <left><left>
" nnoremap <silent> <leader>gb :Gblame<CR>
" nnoremap <leader>gl :Glog 
nnoremap <silent> <leader>gd :Git checkout dev <cr>
nnoremap <silent> <leader>gm :Git checkout master <cr>
nnoremap <silent> <leader>gu :Git push<CR>
nnoremap <silent> <leader>gp :Git pull<CR>
" nnoremap <silent> <leader>gr :Gread<CR>
" nnoremap <silent> <leader>gw :Gwrite<CR>
" nnoremap <silent> <leader>ge :Gedit<CR>
" " Mnemonic _i_nteractive
nnoremap <silent> <leader>gi :Git add -p %<CR>
" nnoremap <silent> <leader>gg :SignifyToggle<CR>

"------------------------------------------------------------------------------------------------
" for youcompleteme
" enable completion from tags
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_server_python_interpreter=g:python_bin
let g:ycm_global_ycm_extra_conf=$VIMPATH . '\plugged\YouCompleteMe\third_party\ycmd\examples\.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt+=menu,menuone
noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript,markdown,css,vim': ['re!\w{2}'],
            \ }
let g:ycm_filetype_whitelist = { 
            \ "c":1,
            \ "cpp":1, 
            \ "go":1, 
            \ "javascript":1, 
            \ "python":1, 
            \ "yaml":1, 
            \ "xml":1, 
            \ "html":1, 
            \ "markdown":1, 
            \ "css":1, 
            \ "vim":1, 
            \ "sh":1,
            \ "zsh":1,
            \ }

" remap Ultisnips for compatibility for YCM
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"-----------------------------------------------------------------------------------

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Haskell post write lint and check with ghcmod
" $ `cabal install ghcmod` if missing and ensure
" ~/.cabal/bin is in your $PATH.
" if !executable("ghcmod")
    " autocmd BufWritePost *.hs GhcModCheckAndLintAsync
" endif

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview

" Snippets {
    " FIXME: Isn't this for Syntastic to handle?
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.
    " if !executable("ghcmod")
        " autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    " endif

" UndoTree {
" if isdirectory(expand("~/.vim/bundle/undotree/"))
    " nnoremap <Leader>u :UndotreeToggle<CR>
    " " If undotree is opened, it is likely one wants to interact with it.
    " let g:undotree_SetFocusWhenToggle=1
" endif

" indent_guides {
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0

" Wildfire {
let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
            \ "html,xml" : ["at"],
            \ }

" vim-airline {
" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols , , , , , , and .in the statusline
" segments add the following to your .vimrc.before.local file:
"   let g:airline_powerline_fonts=1
" If the previous symbols do not render for you then install a
" powerline enabled font.

" See `:echo g:airline_theme_map` for some more choices
" Default in terminal vim is 'dark'
if !exists('g:airline_theme')
    let g:airline_theme = 'solarized'
endif
if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='>'  " Slightly fancier than '>'
    let g:airline_right_sep='<' " Slightly fancier than '<'
endif

"------------------------------------------------------------------------------------------------
" Session List {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>

"------------------------------------------------------------------------------------------------
" for youcompleteme
" Ctags {
set tags=./tags;/,~/.vimtags

" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

"------------------------------------------------------------------------------------------------
" for surround
"    Old text                  Command     New text ~
"    "Hello *world!"           ds"         Hello world!
"    [123+4*56]/2              cs])        (123+456)/2
"    "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
"    if *x>3 {                 ysW(        if ( x>3 ) {
"    my $str = *whee!;         vlllls'     my $str = 'whee!';
"    <div>Yo!*</div>           dst         Yo!
"    <div>Yo!*</div>           cst<p>      <p>Yo!</p>
"    Normal mode
"    -----------
"    ds  - delete a surrounding
"    cs  - change a surrounding
"    ys  - add a surrounding
"    yS  - add a surrounding and place the surrounded text on a new line + indent it
"    yss - add a surrounding to the whole line
"    ySs - add a surrounding to the whole line, place it on a new line + indent it
"    ySS - same as ySs
"    Visual mode
"    -----------
"    s   - in visual mode, add a surrounding
"    S   - in visual mode, add a surrounding but place text on new line + indent it
"    Insert mode
"    -----------
"    <CTRL-s> - in insert mode, add a surrounding
"    <CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
"    <CTRL-g>s - same as <CTRL-s>
"    <CTRL-g>S - same as <CTRL-s><CTRL-s>

" nmap ds  <Plug>Dsurround
" nmap cs  <Plug>Csurround
" nmap cS  <Plug>CSurround
" nmap ys  <Plug>Ysurround
" nmap yS  <Plug>YSurround
" nmap yss <Plug>Yssurround
" nmap ySs <Plug>YSsurround
" nmap ySS <Plug>YSsurround
" xmap S   <Plug>VSurround
" xmap gS  <Plug>VgSurround

"autocmd BufEnter * lcd %:p:h
set cscopetag
" set cscopequickfix=s-,c-,d-,i-,t-,e-
set csto=0
" set csverb
if filereadable("cscope.out")
    cs kill -1
    cs add cscope.out  
endif
"if filereadable("cscope.out")
"    execute "cs add cscope.out"
"endif
"if has('cscope')
"  set cscopetag cscopeverbose
"
"  if has('quickfix')
"    set cscopequickfix=s-,c-,d-,i-,t-,e-
"  endif
"
"  cnoreabbrev csa cs add
"  cnoreabbrev csf cs find
"  cnoreabbrev csk cs kill
"  cnoreabbrev csr cs reset
"  cnoreabbrev css cs show
"  cnoreabbrev csh cs help
"
"  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
"endif

"------------------------------------------------------------------------------------------------
" for php
" for piv
" ,pd  php doc gen 
" <C-x><C-o> complete 
" <S-k> php doc
" for neosnip
" <C-k> snippet
" let g:DisableAutoPHPFolding = 1

" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)

let g:pos = [0, 0, 0, 0]
nnoremap <silent> v :let g:pos = getpos('.')<cr>v
nnoremap <silent> V :let g:pos = getpos('.')<cr>V
nnoremap <silent> <C-v> :let g:pos = getpos('.')<cr><C-v>
"------------------------------------------------------------------------------------------------
" for selfmap
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-h> <C-W>h
nnoremap <A-l> <C-W>l
nnoremap <A-w> <C-w>s
nnoremap <A-v> <C-W>v
nnoremap <A-o> <C-o>
nnoremap <A-i> <C-i>
nnoremap <A-n> <C-]>
inoremap <A-p> <esc>p
inoremap <A-c> <esc>
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-k> <Up>
inoremap <A-j> <Down>
inoremap <A-d> <Del>
inoremap <A-b> <BS>
nnoremap <A-u> <PageUp>
nnoremap <A-d> <PageDown>
vnoremap <A-u> <PageUp>
vnoremap <A-d> <PageDown>
inoremap <A-q> <esc>ZZ
nnoremap <A-q> ZZ
inoremap <A-s> <ESC><ESC>:w!<cr>
nnoremap <A-s> :w!<cr>
" resize current buffer by +/- 5 
nnoremap <A-left> :vertical resize -5<cr>
nnoremap <A-right> :vertical resize +5<cr>
nnoremap <A-down> :resize +5<cr>
nnoremap <A-up> :resize -5<cr>
nnoremap <A-=> <C-W>=

inoremap <Leader><Leader> <esc>A;<cr>
"signify
nnoremap <silent> <F2> : SignifyToggle<CR>
" TagBar {
autocmd FileType tagbar setlocal nocursorline nocursorcolumn

" for redo
nnoremap <silent> <c-u> :<C-U>call repeat#wrap('u',v:count)<CR>
nnoremap <silent> <c-r> :<C-U>call repeat#wrap("\<Lt>C-R>",v:count)<CR>
nnoremap <silent> . :<C-U>exe repeat#run(v:count)<CR>
vnoremap <C-c> y
inoremap <C-v> p

function! g:HeaderguardName()
    " return toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
    let path = expand("%:p")
    let transferedPath = TransferSlashOfPath(g:ProjPath . '\')
    let var = substitute(path, transferedPath, '', '')
    if exists("g:ProjName")
        let var = g:ProjName . '_' . var
    endif
    return toupper(substitute(var, '[^0-9a-zA-Z_]', '_', 'g')) . '_'
endfunction

"------------------------------------------------------------------------------------------------
" for astyle
nnoremap tao : call AstyleFile() <cr>
nnoremap taa : call AstyleAllFiles() <cr>

"------------------------------------------------------------------------------------------------
" for numbers
let g:numbers_exclude = ['taglist', 'unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree']

"------------------------------------------------------------------------------------------------
" for DoxygenToolkit
" let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
" let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="Name:AlexDu Email:duzhichaomail@gmail.com"
let g:DoxygenToolkit_licenseTag="My own license"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:Doxygen_enhanced_color=1
let g:DoxygenToolkit_versionString = "1.0.0"
nnoremap tdd :Dox<cr>
nnoremap tda :DoxAuthor<cr>
" nnoremap tdl :DoxLic<cr>

"------------------------------------------------------------------------------------------------
"for h2cppx
let g:h2cppx_python_path=g:python_bin
nnoremap <silent> thc :call H2cppxAuto()<cr> <bar> :let fname = FSReturnReadableCompanionFilename('%') <bar> call Dos2unix(fname) <cr><bar> : AV<cr><bar> :edit! <cr> 
nnoremap <silent> thg :HeaderguardAdd<cr>

"------------------------------------------------------------------------------------------------
" for vundle
map tpi :PlugInstall <cr>
map tpl :PlugList <cr>
map tpc :PlugClean! <cr>

"------------------------------------------------------------------------------------------------
" for test
nnoremap ttc :messages clear<cr>
nnoremap tte :messages<cr>
nnoremap ttf :call TestFun()<cr>
nnoremap ttm :map<cr>
nnoremap ttv :verbose map <cr>
nnoremap tts :source ~/.vimrc<cr>:simalt ~x<cr>
"for debug slow operation
nnoremap tto :profile start ~/profile.log<cr> <bar> :profile func *<cr> <bar> :profile file *<cr>
nnoremap ttq :profile pause<cr> <bar> :noautocmd qall! <cr>
nnoremap <silent> ttr :%s/\r//g <cr>

"window
nnoremap <silent> two :call browse("", "title", expand("%:h"), "") <cr>
" nnorema <silent> p twm :tearoff File<cr>
" nnorema <silent> p twc :let n = inputdialog("value for shiftwidth")<cr>
nnoremap <silent> twt :exe '1wincmd w'<CR>
nnoremap <silent> twb :exe len(getwininfo()) . 'wincmd w'<CR>
nnoremap <silent> twc :update<Bar>execute '!start cmd /C "' shellescape(g:chrome_bin, 1) shellescape(expand('%:p'), 1) . '"'<CR>
nnoremap <silent> twy :execute '!start cmd /C "' shellescape(g:mintty_bin, 1) ' --dir ' shellescape(expand('%:p:h'), 1) . '"'<CR>
nnoremap <silent> twa :TagbarToggle<CR>:NERDTreeTabsToggle<CR>:wincmd p<CR>
nnoremap <silent> twg :TagbarToggle<CR>
nnoremap <silent> twn :NERDTreeTabsToggle<CR>

"------------------------------------------------------------------------------------------------
" for comment
" nnoremap tc :call CopyFile('') <left><left><left>
nnoremap tca A    //
nnoremap tcb O//
nnoremap tcd : call CommentDebug() <CR>
nnoremap tcm : call CommentModified() <CR>
nnoremap tct : call CommentTodo() <CR>

"------------------------------------------------------------------------------------------------
" for vim log
nnoremap tlt :if(g:debug_log)<bar>let g:debug_log=0<bar>else<bar>let g:debug_log=1<bar>endif<cr>
nnoremap tls :echo g:debug_log<cr>
nnoremap tlo :exe 'botright split ' . g:log_file<cr>
nnoremap tld :call delete(g:log_file)<cr>

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
"nmap <Leader>ac <Plug>ToggleAutoCloseMappings

" Setting the author var
" If forking, please overwrite in your .vimrc.local file
let g:snips_author = 'xiaozhi <duzhichaomail@gmail.com>'

"-----------------------------------------------------------------------------
" nmap <Leader>ta <Plug>ToggleAutoCloseMappings
" nmap <Leader>ti <Plug>IndentGuidesToggle
map <silent> <F9> :call misc#path#Rsync(g:proj_path, g:remote_user, g:remote_addr, g:remote_port, g:remote_path, g:remote_proxy, g:remote_identity_file)<Bar>if(!empty(g:remote_callback))<Bar>call misc#SshCmd(g:remote_user, g:remote_addr, g:remote_port, g:remote_proxy, g:remote_identity_file, g:remote_callback)<Bar>endif<Cr>
map <silent> <F10> :call misc#Zip(g:proj_path, ingo#fs#path#Combine(g:zip_out_path, g:proj_name . '.zip'), g:zip_exclude)<CR>
map <silent> <F12> :call misc#DoCtagsAndCscope(g:proj_path, g:proj_type, g:cscopes_options)<CR>

"------------------------------------------------------------------------------------------------
function! TestFun()
    " let g:CtagsAndCscopesExcludeVendor = 1
    if(exists("g:CtagsAndCscopesExcludeVendor") && g:CtagsAndCscopesExcludeVendor)
        let var = '-----------'
    else
        let var = '============'
    endif

    echo var
    " call RunShellCommand('ls')
    " let file = '\src\RandomGenerator.h'
    " if(file =~ '\\$')
        " let file = strpart(file, 0, strlen(file) - 1)
    " endif
    " call append(line(".")-1, file)

    " let companion = FSReturnReadableCompanionFilename('%')
    " let tmp = system("ls")
    " let fullpath = expand(a:fname . ":p:h")
    " let fullpath = expand("%:p:h")
    " call append(line(".")-1,companion)
    " echo %%
    " echo fnameescape(expand('%'))
    " echo fnameescape(expand('%:h')).'/'
    " cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    " let cmd = '! echo "'.ret.'" > cscope.files'
    " let line = line(".")-1
    " call append(line(".")-1,cmd)
    " call append(line,ret)
    " echo cmd
    " echo ret > cscope.files 
    " silent! execute cmd
    " let cmd = '! C:\Users\AlexDu\app\Cygwin\bin\find.exe '.ConvertToCygPath(g:ProjPath)." -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
    " silent! execute "!C:\Users\AlexDu\app\Cygwin\bin\find.exe ".ConvertToCygPath(g:ProjPath)." -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
    " silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> test.file"
    " let path = g:ProjPath
    " let find = '! C:\Users\AlexDu\app\Cygwin\bin\find.exe '
    " let find = 'C:\Users\AlexDu\app\Cygwin\bin\find.exe '
    " let para = ' -type d ! -path "*.svn*" ! -path "*.git*" '
    " " let out = ' >> ~vimtmpfile'
    " " let cmd = find.path.para.out
    " let cmd = find.path.para
    " silent! exec cmd
    " let ret = system(cmd)
    " let ret = ':set path+='.ret
    " " dirlist2=`echo $dirlist | sed 's/\.\//,/g' | sed 's/\.//g' | sed 's/ //g' | sed 's/,//'`;
    " echo ret
    " let line = line(".")-1
    " " call append(line,ret)
    " silent! exec ret
    " let addpath=system("cat ~vimcurpath.tmp")
    " execute addpath
    " let line = line(".")-1
    " call append(line,cmd)
    " let file = 'and/txt.cpp'
    " let list = split(file,'\.')
    " let suffix = list[-1]
    " if suffix =~ "c" || suffix =~ "cpp" || suffix =~ "h"
    " echo "c"
    " elseif suffix =~ "php"
    " echo "not"
    " endif
    " let rsync = 'C:\Users\AlexDu\app\Cygwin\bin\rsync.exe -achP'
    " let path = ConvertToCygPath(rsync)
    " let line = line(".")-1
    " call append(line,path)
endfunction

"------------------------------------------------------------------------------------------------
" rsync
" function! Rsync()
    " " let rsync = 'C:\Users\AlexDu\app\Cygwin\bin\rsync.exe -avzuh'
    " let rsync = 'C:\tools\cygwin\bin\rsync.exe -avzuh'
    " let files = g:ProjPath
    " if(g:Is_Identity_File)
        " let ssh = "/usr/bin/ssh"
        " let identity = 'D:\comicool\secretKey\internal-key-private.bin'
        " let identity = path#ConvertToCygPath(identity)
        " let rsync = rsync." -e '".ssh." -i ".identity."'"
    " endif
    " let remote = g:RsyncUser.":".g:RsyncRemoteDir
    " let files = path#ConvertToCygPath(files)
    " let cmd = "! ".rsync." ".files." ".remote
    " silent exec cmd
    " if(exists("g:After_Rsync_Callback") && g:After_Rsync_Callback)
        " " let ssh = '!C:\Users\AlexDu\app\Cygwin\bin\ssh.exe '
        " let ssh = '!C:\tools\cygwin\bin\ssh.exe '
        " let callback = ssh.g:RsyncUser.' "'.g:Callback.'"'
        " silent exec callback
    " endif
" endfunction

"------------------------------------------------------------------------------------------------
" zip
" function! Zip()
    " let bash = 'C:\tools\cygwin\bin\bash.exe'
    " let zipdir = path#ConvertToCygPath(g:ProjPath)
    " if exists("g:ZipDir")
        " let zipdir = path#ConvertToCygPath(g:ZipDir)
    " endif
    " let zipfile = '/cygdrive/c/Users/alexzcdu/Desktop/zip_file/' . g:ProjName . '.zip '
    " let exclude =  " * -x  '*.so' '*.so.*' '*.a' '*tags' '*cscope.files' '*cscope.out' " . g:ZipExclude
    " let cmd = '! '. bash .' -c "pushd ' . zipdir . '; zip -r ' . zipfile . exclude . '"' . ";popd"
    " " call append(line(".")-1, cmd)
    " silent exec cmd
" endfunction

"------------------------------------------------------------------------------------------------
" for ctags and cscope 
" function! DeleteCtagsAndCscopeFiles()
    " let tagsfile = g:ProjPath."\\tags"
    " let cscopefile = g:ProjPath."\\cscope.files"
    " let cscopeout = g:ProjPath."\\cscope.out"
    " if filereadable(tagsfile)
        " let tagsdeleted=delete(tagsfile)
        " if(tagsdeleted!=0)
            " echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            " return
        " endif
    " endif
    " silent execute "cs kill -1"
    " if filereadable(cscopefile)
        " let csfilesdeleted=delete(cscopefile)
        " if(csfilesdeleted!=0)
            " echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            " return
        " endif
    " endif
    " if filereadable(cscopeout)
        " let csoutdeleted=delete(cscopeout)
        " if(csoutdeleted!=0)
            " echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            " return
        " endif
    " endif
" endfunction

" function! DoCtagsAndCscope()
    " " let g:ProjPath = 'D:\muduo\examples\pingpong'
    " " let g:ProjType = 'cpp'
    " " let g:CtagsAndCscopesExcludeVendor = 1
    " let dir = getcwd()
    " let path = substitute(g:ProjPath,"/","\\","g")
    " execute ":cd ".path
    " call DeleteCtagsAndCscopeFiles()
    " let l:findBin = $CYG.'/find'
    " let l:findPara = ''
    " if g:ProjType ==# 'cpp'
        " " silent execute "!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaS --extra=+q ."
        " " let l:ctagscmd = g:ctags_bin . ' -R --exclude=boost --c++-kinds=+p+l+x --fields=+iaS --extras=+q .'
        " let l:ctagsPara =  ' --c++-kinds=+p+l+x --fields=+iaS --extras=+q -L '
        " if(exists("g:CtagsAndCscopesExcludeBoost") && g:CtagsAndCscopesExcludeBoost)
            " let l:findPara = " -path '*boost*' -prune -o"
        " endif
        " let l:findPara = l:findPara." -regex \".*\\.\\(h\\|c\\|cpp\\|cc\\|hpp\\)\" -print"
    " elseif g:ProjType ==# 'go'
        " " let l:ctagscmd = g:ctags_bin . ' -R --fields=+afmikKlnsStzZ --extras=+q .'
        " let l:ctagsPara = ' --fields=+afmikKlnsStzZ --extras=+q -L '
        " if(exists("g:CtagsAndCscopesExcludeVendor") && g:CtagsAndCscopesExcludeVendor)
            " let l:findPara = " -path '*vendor*' -prune -o"
        " endif
        " let l:findPara = l:findPara." -name '*_test.go' -o -name '*.go' -print"
    " elseif g:ProjType ==# 'js'
        " let l:ctagsPara = ' --fields=+nksSaf -V --language-force=javascript --javascript-kinds=vCcgpmf -L '
        " let l:findPara = l:findPara." -name '*.js' -o -name '*.html' "
    " elseif g:ProjType ==# 'php'
        " let l:ctagsPara = ' --exclude=".svn" --exclude=".git" --totals=yes --tag-relative=yes --regex-PHP="/abstract\s+class\s+([^ ]+)/\1/c/" --regex-PHP="/interface\s+([^ ]+)/\1/c/" --regex-PHP="/(public\s+|static\s+|protected\s+|private\s+)\$([^ =]+)/\2/p/" --regex-PHP="/const\s+([^ =]+)/\1/d/" --regex-PHP="/final\s+(public\s+|static\s+|abstract\s+|protected\s+|private\s+)function\s+\&?\s*([^ (]+)/\2/f/" --PHP-kinds=+cfpd --extras=+q -L '
        " let l:findPara = l:findPara." -name '*.js' -o -name '*.php' -o -name '*.html' -print"
    " elseif g:ProjType ==# 'python'
        " let l:ctagsPara = ' --python-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v+i --fields=+iaS --extras=+q -L '
        " let l:findPara = l:findPara." -name '*.py' -print"
    " endif
    " let cmd = l:findBin.' '.ConvertToCygPath(g:ProjPath).l:findPara

    " " call append(line(".")-1, cmd)
    " let ret = path#ConvertToWinPath(system(cmd))
    " let fileList = split(ret)
    " " call append(line(".")-1, ret)
    " let cscopefile = g:ProjPath."\\cscope.files"
    " call writefile(fileList, cscopefile, "b")
    " let l:ctagsCmd = g:ctags_bin . l:ctagsPara . cscopefile
    " let l:cscopeCmd = g:cscope_bin . " -Rbk -s " . g:ProjPath

    " call system(l:ctagsCmd)
    " call system(l:cscopeCmd)
    " " silent execute "normal :"
    " if filereadable("cscope.out")
        " silent execute "cs add cscope.out"
    " endif
    " execute ":cd ".dir
    " " :set tags+=$VIMPROJ/vimlib/tags,$VIMPROJ/vimlib/linux/tags,$VIMPROJ/vimlib/unix_network_programming/tags
    " " :set path+=$VIMPROJ/vimlib/cpp_src,$VIMPROJ/vimlib/linux/include,$VIMPROJ/vimlib/linux/include/sys/,$VIMPROJ/vimlib/unix_network_programming/
" endfunction


"-------------------------------------------------------------------------------------------------
" function! AstyleAllFiles()
    " let cscopefile = g:ProjPath."\\cscope.files"
    " for line in readfile(cscopefile)
        " echo line
        " let astyle_file=expand("%:p")
        " " let cmd ='!astyle.exe -A3Lfpjk3S --mode=c --ascii -n '.line
        " let cmd ='!astyle.exe -A1Lfpjk3S --mode=c --ascii -n '.line
        " silent execute cmd
        " " exec 'normal :%s/\r//g <cr>'
    " endfor
" endfunction

" "-------------------------------------------------------------------------------------------------
" function! AstyleFile()
    " let astyle_file=expand("%:p")
    " " let cmd ='!astyle.exe -A3Lfpjk3S --mode=c --ascii -n '.astyle_file
    " let cmd ='!astyle.exe -A1Lfpjk3S --mode=c --ascii -n '.astyle_file
    " silent execute cmd
    " exec 'normal :%s/\r//g <cr>'
" endfunction

"------------------------------------------------------------------------------------------------
function! CommentModified()
    let line = line(".")-1
    let str = "//duzhichaomail@gmail.com  time:".strftime("%c")."  reason:"
    call append(line,str)
    exec "normal k"
    startinsert!
endfunction

function! CommentTodo()
    let line = line(".")-1
    let str = "// TODO : "
    call append(line,str)
    exec "normal k"
    startinsert!
endfunction

function! CommentDebug()
    let line = line(".")
    let str = "// debug duzhichaomail time:".strftime("%c")."  begin"
    call append(line,str)
    let line3 = line(".")+1
    let str3 = "// debug duzhichaomail  time:".strftime("%c")."  end"
    call append(line3,str3)
    exec "normal j"
    exec "normal o"
    startinsert!
endfunction


"------------------------------------------------------------------------------------------------
"CopyFile()
function! CopyFile(fname)
    let ext = expand('%:e')
    let bin = '! C:\Users\AlexDu\app\Cygwin\bin\cp.exe'
    let fromPath = expand("%:p")
    let toPath = expand("%:p:h")
    let toPath = path#ConvertToCygPath(toPath)
    let tofile = toPath.'/'.a:fname.'.'.ext
    let fromPath = path#ConvertToCygPath(fromPath)
    let cmd = bin.' '.fromPath.' '.tofile
    echo cmd
    silent! execute cmd
    exec "normal : e ".tofile." <cr>"
endfunction

"------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------
"dos2unix()
function! Dos2unix(fname)
    let name = path#ConvertToCygPath(a:fname)
    let cmd = 'sed.exe -i "s/\r//g" ' . name
    let res = system(cmd)
endfunction
