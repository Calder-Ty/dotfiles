set nocompatible              " be iMproved, required
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" set term=xterm-256color
" set term=tmux-256color
set termguicolors
set winaltkeys=no
" Setting aoutocompletion I think..
let g:ale_completion_enabled=1
set omnifunc=ale#completion#Omnifunc

hi Comment guifg=green

" Get rid of the infernal bell thank you very much
set noerrorbells
set visualbell
let mapleader=" "


" enable filetype detection
filetype on
" enable plugins and load plugins based on filetype
filetype plugin indent on
syntax on


" Display tabs as 4 spaces in size
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" Editor Configurations
"
" Cursor apperance
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

set signcolumn=yes
hi signcolumn ctermbg=Black
" Set a ruler
set ruler
" Relative numbering
set nu rnu
" General formatting
"colorscheme darkblue
"

" Faster macros
set lazyredraw
" show matching {[()]}
set showmatch
" folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set splitbelow
set hidden

" Running code
nnoremap <leader>r :RustRun<CR>



" Terminal Stuff
"
" set termwinsize=10x0
nnoremap <leader><C-j> :term<space>++rows=10<CR>



" Status Bar colors
"
hi StatusLine ctermfg=DarkCyan

" Keyboard Shorcuts
"
" map jk to esc
inoremap jk <esc>
" set mapleader
" Session managment: save
nnoremap <leader>s :mksession<CR>
" Quick edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rr :source $MYVIMRC<cr>

" Move lines in visual mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Comment and uncomment lines
autocmd FileType c,cpp,java,scala,rs let b:comment_leader = '//'
autocmd FileType sh,ruby,python   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType tex              let b:comment_leader = '%'
autocmd FileType mail             let b:comment_leader = '>'
autocmd FileType vim              let b:comment_leader = '"'
autocmd FileType sql              let b:comment_leader = '--'

function! CommentToggle()
	    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
	    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
noremap <leader>/ :call CommentToggle()<CR>


" netrw config
" let g:netrw_keepdir=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
let g:netrw_banner=0

nnoremap <leader><C-a> :Lexplore<cr>

function! NetrwMapping()
	nmap <buffer> l <cr>
	nmap <buffer> L <cr>:Lexplore<CR>
	noremap <buffer> <leader>dd :Lexplore<CR>
endfunction

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END


" TODO: Things I Want
" 	- gd
"	- gh for info on something, error
"	- gf
"	- A better way open and close terminal (Maybe a TMUX thing)
"	- Spellchecker
"	- Close and go to previous buffer
"	- Color Scheme
"	- Trim Whitespace
"	- Copy to systemclipboard needs to work

" Custom Personal Plugins
" set spell
set spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline


" Trim Whitespace


" Plugins
"
"
" Ag stuff:
"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <leader>a :Ack<space>

" FZF!
"
set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>

" ALE
"
" python
let g:ale_python_executable="python3"
let g:ale_python_pylint_executable="pylint"
let g:ale_python_pylint_use_global=0
let g:ale_python_pylsp_executable="pyls"
let g:ale_python_pylsp_use_global=1
let g:ale_python_pylsp_executable="pyls"

nnoremap <leader>gh :ALEHover<CR>

set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled=1
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']}

let g:ale_linters = {
			\ 'rust': ['analyzer'],
			\ 'python': ['pylint', 'pylsp']
			\}
let g:ale_fix_on_save = 1

" Undo-Tree
"
" Toggle View
nnoremap <F5> :UndotreeToggle<CR>

noremap <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
