"''''''''''''''''''''''''''''''''''''''''''''''''''''''''

" переключение языков
fun! SwitchLanguage()
	if &iminsert == 0
		set iminsert=1
	else
		set iminsert=0
	endif
endfunction

fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
	write
endfun

autocmd BufWrite <buffer> :call <SID>StripTrailingWhitespaces()
autocmd BufRead if &buftype == "quickfix" <buffer> nnoremap o <CR> endif

let g:mapleader=','

set autoindent
set autoread	" автоматически загружать внешние изменения файла
" set list " отображать симоволы табуляции
set nocompatible
set nohlsearch " no highlight search result after <cr>
set incsearch  " highlight search result while typing
set noswapfile
set number	    " нумерование строк
set relativenumber
set shiftwidth=4
set smartindent " умные отступы
set smarttab
set splitright
set tabstop=4
set splitbelow
set nowrap

set mousehide
set mouse=a
set novisualbell
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showtabline=1 " set foldcolumn=1

set keymap=russian-dictor
set iminsert=0
set imsearch=0
set foldmethod=syntax
set foldlevelstart=99
set ttimeoutlen=0 " Чтобы не было задержек
set encoding=utf-8





" "'''''''''''''''''''''''' PLUGINS ''''''''''''''''''''''''''
call plug#begin('~/.config/nvim/autoload/plugged')


" Plug 'vim-airline/vim-airline'
Plug 'powerline/powerline'

Plug 'fweep/vim-tabber'
	" let g:tabber_wrap_when_shifting = 1
	let g:tabber_filename_style = 'filename'
	" nnoremap gp :TabberSelectLastActive<CR>
	" nnoremap g<left>  :TabberShiftLeft<CR>
	" nnoremap g<right> :TabberShiftRight<CR>

" Plug 'ycm-core/YouCompleteMe' " автодополнение
	" " let g:ycm_clangd_binary_path = "/usr/bin/clangd"
	" let g:ycm_global_ycm_extra_conf              = '~/.ycm_extra_conf.py'
	" let g:ycm_confirm_extra_conf                 = 0
	" let g:ycm_max_num_candidates                 = 50
	" let g:ycm_key_list_select_completion         = [ '<tab>', '<down>', '<c-k>' ]
	" let g:ycm_key_list_previous_completion       = [ '<up>' ]
	" let g:ycm_auto_trigger                       = 1
	" let g:ycm_min_num_of_chars_for_completion    = 2
	" let g:ycm_show_diagnostics_ui                = 0
	" let g:ycm_enable_diagnostic_signs            = 0
	" let g:ycm_filter_diagnostics                 = { "cpp": { "level": "warning" } }
	" let g:ycm_key_list_stop_completion           = ['']
	" let g:ycm_key_invoke_completion              = '<c-space>'
	" let g:ycm_semantic_triggers                  = {
				" \ 'c' : [ 're!\w{5,20}'],
				" \ 'cpp' : [ 're!\w{5,20}']
				" \ }
	" set completeopt-=preview
	" nnoremap gd :YcmCompleter GoTo<cr>
	" nnoremap gs :YcmCompleter GoToSymbol<space>


Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	 if has("patch-8.1.1564")
	   set signcolumn=number
	 else
	   set signcolumn=yes
	 endif

	 inoremap <silent><expr> <Tab>
		   \ pumvisible() ? "\<C-n>" :
		   \ <SID>check_back_space() ? "\<Tab>" :
		   \ coc#refresh()

	 inoremap <silent><expr> <C-k>
		   \ pumvisible() ? "\<C-n>" :
		   \ <SID>check_back_space() ? "\<C-k>" :
		   \ coc#refresh()

	 function! s:check_back_space() abort
	   let col = col('.') - 1
	   return !col || getline('.')[col - 1]  =~ '\s'
	 endfunction

	 " Use <c-space> to trigger completion.
	if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
	else
	  inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap     <silent> [g <Plug>(coc-diagnostic-prev)
	nmap     <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap     <silent> gd <Plug>(coc-definition)
	nmap     <silent> gy <Plug>(coc-type-definition)
	nmap     <silent> gI <Plug>(coc-implementation)
	nmap     <silent> gr <Plug>(coc-references)
	nnoremap <silent> gD :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	  elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	  else
		execute '!' . &keywordprg . " " . expand('<cword>')
	  endif
	endfunction

Plug 'scrooloose/nerdcommenter' " комментирование
" Plug 'tpope/vim-commentary' " ещё один плагин на комментирование


Plug 'SirVer/ultisnips' " сниппеты
	 let g:UltiSnipsExpandTrigger="<c-j>"
	 let g:UltiSnipsJumpForwardTrigger="<tab>"
	 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
	 let g:UltiSnipsEditSplit="vertical"

" Plug 'vim-scripts/highlight_current_line.vim'

Plug 'scrooloose/nerdtree' " просмотр файловой системы
	 map <C-n> :NERDTreeToggle<CR>
	 let NERDTreeIgnore=['\~$', 'target', 'trg', '*.o']
	 let g:NERDSpaceDelims     = 2
	 let g:NERDTreeAutoCenter  = 0
	 let g:NERDTreeMinimalMenu = 1
	 let g:NERDTreeMinimalUI   = 1
	 let g:NERDTreeMouseMode   = 1

 " If another buffer tries to replace NERDTree, put it in the other
 " window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && 
\	bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | 
\	let buf=bufnr() | buffer# | execute "normal! \<C-W>w" |
\	execute 'buffer'.buf | endif

 " Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') &&
\	b:NERDTree.isTabTree() | quit | endif

 " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
\	exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

Plug 'Xuyuanp/nerdtree-git-plugin'
	let g:NERDTreeGitStatusIndicatorMapCustom = {
\		'Modified'  :'✹',
\		'Staged'    :'✚',
\		'Untracked' :'✭',
\		'Renamed'   :'➜',
\		'Unmerged'  :'═',
\		'Deleted'   :'✖',
\		'Dirty'     :'✗',
\		'Ignored'   :'☒',
\		'Clean'     :'✔︎',
\		'Unknown'   :'?',
\	}
	let g:NERDTreeGitStatusUseNerdFonts = 1

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'PhilRunninger/nerdtree-visual-selection'
" Plug 'jistr/vim-nerdtree-tabs'

Plug 'easymotion/vim-easymotion'
	map <Leader> <Plug>(easymotion-prefix)
	" ,s<sym> - Найти символ
	" ,f<sym> - Найти символ после текущей позиции
	" ,w<sym> - К началу слова после текущий позиции
	" ,W<sym> - К началу СЛОВА после текущий позиции
	" ,b<sym> - К началу слова перед текущей позицией
	" ,B<sym> - К началу СЛОВА перед текущей позицией
	" ,e<sym> - К конча слова после текущей позицией
	" ,E<sym> - К началу слова после текущей позицией

" Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'https://github.com/tpope/vim-surround'
	" cs'" - заменить ' на " ( можно указывать любые скобки: `'[{(<' )
	" yss) - обернуть данную строку в скобки ()
	" ds(  - удалить пару скобок ()
	" ct<div> - изменить тег на <div>
	" в команде yss вместо последней s можно исполизовать сочетания типа iw,aw...

Plug 'https://github.com/mattn/emmet-vim'
	" >  child
	" +  sibling
	" ^  climb-up
	" *n multiplication (li*4)
	" () grouping (dt+dd)*3 or div>(div>div>div)+div
	"
	" #id
	" .class.class
	" [attr='attr_value']
	" $*5 item numering li.item$*3 -> class='item1' ... 'item2' ... 'item3' (can $$)
	"
	" a{click me}   text
	" space is stop-symbol

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	nnoremap gi :vnew<CR>:FZF<CR>
	nnoremap gh :new<CR>:FZF<CR>
	nnoremap gz :tabnew<CR>:FZF<CR>
	nnoremap ge :Ag<SPACE>""<left>
	nnoremap go :FZF<CR>

Plug 'KabbAmine/vCoolor.vim' " color-picker <Alt+c>
	let g:vcoolor_map = '<C-c>'

Plug 'https://github.com/tpope/vim-repeat'
Plug 'reconquest/vim-pythonx'
Plug 'junegunn/vim-easy-align' " выравнивание
	xmap ga <Plug>(EasyAlign)
	nmap ga <Plug>(EasyAlign)
	" vipga=    # выровнять параграф по символу = (первое вхождение)
	" gaip=     # то же самое
	" gaip2=    # по второму вхождению
	" gaip-=    # по последнему вхождению
	" gaip*,    # выровнять по всем запятым
	" gaip**,   # выравнивать сначала по левому краю, потом по правому,
	"             чередовать
	" gaip*^X   # выровнять по регулярному выражению
	" ..^L      # левый отступ
	" ..^R      # правый отступ
	" ..<ENTER> # изменить тип выравнивание (влево, по центру, вправо)
	" ..<C-P>   # показывать выравнивание в настоящем времени

" Plug 'terryma/vim-multiple-cursors'
	" let g:multi_cursor_use_default_mapping = 0
	" let g:multi_cursor_start_word_key      = 'mm'
	" let g:multi_cursor_select_all_word_key = 'ma'
	" let g:multi_cursor_start_key           = 'mb'
	" let g:multi_cursor_select_all_key      = 'mk'
	" let g:multi_cursor_next_key            = 'mm'
	" let g:multi_cursor_prev_key            = 'mp'
	" let g:multi_cursor_skip_key            = 'mx'
	" let g:multi_cursor_quit_key            = '<Esc>'
	" nnoremap ms :MultipleCursorsFind<Space>
	" vnoremap ms :MultipleCursorsFind<Space>

" Plug 'paradigm/vim-multicursor'
	" nnoremap mp :<c-u>call MultiCursorPlaceCursor()<cr>
	" nnoremap mm :<c-u>call MultiCursorManual()<cr>
	" nnoremap mr :<c-u>call MultiCursorRemoveCursors()<cr>
	" xnoremap mp :<c-u>call MultiCursorVisual()<cr>
	" xnoremap ms :<c-u>call MultiCursorSearch('
	" let g:multicursor_quit = '<Esc>'

Plug 'tikhomirov/vim-glsl' " Подсветка синтаксиса для GLSL
	autocmd! BufNewFile,BufRead *.vs,*.fs,*.frag set ft=glsl

" " packadd! vimspector
	" " let g:vimspector_enable_mappings = 'HUMAN'
	" " map <F22> :call vimspector#StepInto()<CR>

Plug 'ryanoasis/vim-devicons'
	set guifont=DroidSansMono\ Nerd\ Font\ 10
	let g:airline_powerline_fonts = 1

Plug 'jupyter-vim/jupyter-vim'
	let g:python3_host_prog = '/usr/bin/python3'
	let g:jupyter_mapkeys   = 0
	" Run current file
	au FileType python nnoremap <silent> <buffer> <leader>o :JupyterRunFile<CR>
	" au FileType python map <silent> <buffer> <leader>I :PythonImportThisFile<CR>

	" Change to directory of current file
	" au FileType python map <silent> <buffer> <leader>d :JupyterCd %:p:h<CR>
	" Send a selection of lines
	au FileType python nnoremap <silent> <buffer> <leader>x  :JupyterSendCell<CR>
	au FileType python nnoremap <silent> <buffer> <leader>E  :JupyterSendRange<CR>
	au FileType python nnoremap <silent> <buffer> <leader>e  V<leader>e<esc>
	au FileType python vnoremap <silent> <buffer> <leader>e  <Plug>JupyterRunVisual
	au FileType python nnoremap <buffer> <silent> <leader>cc :JupyterConnect<CR>
	au FileType python nnoremap <buffer> <silent> <leader>U  :JupyterUpdateShell<CR>

	" Debugging maps
	au FileType python nnoremap <buffer> <silent> <leader>b :PythonSetBreak<CR>

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'jiangmiao/auto-pairs'
	let g:AutoPairs = { "[" : "]", "{" : "}", "'":"'", '"':'"', "`":"`",
\									'```':'```', '"""':'"""', "'''":"'''" }
	let g:AutoPairsShortcutToggle = ''

Plug 'rust-lang/rust.vim'

" SCHOOL 21
Plug 'cacharle/c_formatter_42.vim'
	au FileType           c   nnoremap <silent> <buffer> <leader>dn :w<CR>:Norminette<CR>
	au FileType           c   nnoremap <silent> <buffer> <leader>df :CFormatter42<CR>:w<CR>
	au FileType           c   vnoremap <silent> <buffer> <leader>df :'<,'>!c_formatter_42<CR>
	au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>dn :w<CR>:NorminetteHeader<CR>
	au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>df :CFormatter42<CR>:w<CR>
	au BufNewFile,BufRead *.h vnoremap <silent> <buffer> <leader>df :'<,'>!c_formatter_42<CR>

Plug 'pbondoer/vim-42header'
	au FileType           c   nnoremap <silent> <buffer> <leader>dh :Stdheader<CR>
	au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>dh :Stdheader<CR>

Plug 'matze/vim-move'
	nmap <C-j> <Plug>MoveLineDown
	nmap <C-k> <Plug>MoveLineUp
	vmap <C-j> <Plug>MoveBlockDown
	vmap <C-k> <Plug>MoveBlockUp

Plug 'vim-utils/vim-man'
" Plug 'octol/vim-cpp-enhanced-highlight'
	let g:cpp_class_scope_highlight                  = 1
	let g:cpp_member_variable_highlight              = 1
	let g:cpp_class_decl_highlight                   = 1
	" let g:cpp_concepts_highlight                     = 1
	" let g:cpp_posix_standard                         = 1
	let g:cpp_experimental_simple_template_highlight = 1
	" let g:cpp_experimental_template_highlight        = 1
	let c_no_curly_error                             = 1
	" au FileType cpp syntax keyword Operator template typename
" Plug 'bfrg/vim-cpp-modern'

Plug 'airblade/vim-gitgutter'
	let g:gitgutter_map_keys = 0
	" set signcolumn=yes " always have sign column
	nnoremap <silent> <leader>gq :GitGutterQuickFix \| copen<CR>
	nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>:w<CR>:GitGutterAll<CR>
	nnoremap <silent> <leader>gs :GitGutterStageHunk<CR>:w<CR>:GitGutterAll<CR>
	nnoremap <silent> <leader>gp :GitGutterPreviewHunk<CR>
	nnoremap <silent> <leader>gf :GitGutterFold<CR>
	nnoremap <silent> <leader>gh :GitGutterLineHighlightsToggle<CR>
	nnoremap ]c :GitGutterNextHunk<CR>
	nnoremap [c :GitGutterPrevHunk<CR>
	au BufWrite * :GitGutterAll

Plug 'tpope/vim-fugitive'

Plug 'dbeniamine/cheat.sh-vim'

" Подсветка цветов по HTML-коду
" Значительно замедляет загрузку больших (>1000 строк) файлов
" Plug 'lilydjwg/colorizer'

" " Разноцветная подсветка скобок
Plug 'luochen1990/rainbow'
	let g:rainbow_active = 1
	let g:rainbow_conf = {
\		'separately': {
\			'html':     0,
\			'nerdtree': 0
\		}
\	}

" Анимация пульсации при поиске
" Plug 'inside/vim-search-pulse'
	" let g:vim_search_pulse_duration = 100

" Красивые комментарии
" Plug 'cometsong/CommentFrame.vim'
	" let g:CommentFrame_SkipDefaultMappings = 1 " to not use default keymaps
	" let g:CommentFrame_TextWidth = 80
	" Basic Usage:

	" The default keymappings are setup for a custom function to create a CommentFrame
	" and also a CommentRight line.  All keymapping start with <Leader>, all default
	" frames and right lines are 80 characters.

	" Key     Command Name                Result
	" ---     --------------------------  ----------------------------------------
	" fcs     CommentFrameSlashes         border: //****************************//
	" fcS     CommentFrameSlashStar       border: /******************************/
	" fch     CommentFrameHashDash        border: #------------------------------#
	" fcH     CommentFrameHashEqual       border: #==============================#
	" fcq     CommentFrameQuoteDash       border: "------------------------------"
	" fcQ     CommentFrameQuoteTilde      border: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

	" frh     CommentRightHash            line: #~~~~~~~~~~~~~~~~~~~~~ title ~~~~~
	" frs     CommentRightSlashes         line: //~~~~~~~~~~~~~~~~~~~~ title ~~~~~
	" frS     CommentRightSlashStar       line: /*~~~~~~~~~~~~~~~~~~ title ~~~~~*/
	" frq     CommentRightQuote           line: "~~~~~~~~~~~~~~~~~~~~~ title ~~~~~

" Plug 'AndrewRadev/splitjoin.vim'
	" gS - split
	" gJ - join

" Новый текстовый объект, определённый по уровню отступов
Plug 'michaeljsmith/vim-indent-object'

Plug 'maxbrunsfeld/vim-yankstack'
	let g:yankstack_map_keys = 0
	let g:yankstack_yank_keys = ['y']
	nmap <A-p> <Plug>yankstack_substitute_older_paste
	xmap <A-p> <Plug>yankstack_substitute_older_paste
	imap <A-p> <Plug>yankstack_substitute_older_paste
	nmap <A-i> <Plug>yankstack_substitute_newer_paste
	xmap <A-i> <Plug>yankstack_substitute_newer_paste
	imap <A-i> <Plug>yankstack_substitute_newer_paste

" Plug 'mattn/webapi-vim'
" Plug 'mattn/vim-gist'

" Переключение между заголовочными и исходными файлами
Plug 'linluk/vim-c2h'
	" ,ch

" SQL
Plug 'joereynolds/SQHell.vim'
	au FileType sql,mysql nnoremap <buffer> <leader>cc
		\ :r !mysql -unvx -ppassword -h localhost <<< `cat %` \| column -t<cr>
	au FileType sql,mysql nnoremap <buffer> <leader>e :SQHExecute<cr>
	au FileType sql,mysql nnoremap <buffer> <leader>E :SQHExecute!
	au FileType sql,mysql vnoremap <buffer> <leader>e :SQHExecute<cr>

	let g:sqh_provider       = 'mysql'
	let g:sqh_results_output = 'smart'
	let g:sqh_connections    = {
\		'default': {
\			'user':     'nvx',
\			'password': 'password',
\			'host':     'localhost',
\			'database': 'film'
\		}
\	}

" " TODO list
Plug 'aserebryakov/vim-todo-lists'
	let g:VimTodoListsUndoneItem = '- [ ]'
	let g:VimTodoListsDoneItem   = '- [X]'
	let g:VimTodoListsMoveItems  = 1
	
	" VimTodoListsCreateNewItemAbove - creates a new item in a line above cursor
	" VimTodoListsCreateNewItemBelow - creates a new item in a line below cursor
	" VimTodoListsCreateNewItem      - creates a new item in current line
	" VimTodoListsGoToNextItem       - go to the next item
	" VimTodoListsGoToPreviousItem   - go to the previous item
	" VimTodoListsToggleItem         - toggles the current item (or selected items in visual mode)
	" VimTodoListsIncreaseIndent     - increases the indent of current line
	" VimTodoListsDecreaseIndent     - decreases the indent of current line

	" Default mapping
	" j           - go to next item
	" k           - go to previous item
	" O           - create new item above the cursor
	" o           - create new item below the cursor
	" <Space>     - toggle current item
	" <CR>        - create new item in insert mode
	" <Tab>       - increases the indent of current (or selected) line(s)
	" <Shift-Tab> - decreases the indent of current (or selected) line(s)
	" <leader>e   - switch to normal editing mode

	let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'
	let g:VimTodoListsDatesEnabled    = 1

	function! VimTodoListsCustomMappings()
		nnoremap <buffer> <silent> <leader>O :VimTodoListsCreateNewItemAbove<CR>
		nnoremap <buffer> <silent> <O        :VimTodoListsCreateNewItemAbove<CR>
		nnoremap <buffer> <silent> <leader>o :VimTodoListsCreateNewItemBelow<CR>
		nnoremap <buffer> <silent> <Space>   :VimTodoListsToggleItem<CR>
		noremap  <buffer> <silent> >>        :VimTodoListsIncreaseIndent<CR>
		noremap  <buffer> <silent> <tab>     :VimTodoListsIncreaseIndent<CR>
		noremap  <buffer> <silent> <<        :VimTodoListsDecreaseIndent<CR>
	endfunction

" Чтобы в больших вайлах свёртка кода не перерасчитывалась при введение
" каждого символа
Plug 'Konfekt/FastFold'

" Добавление заголовка
Plug 'alpertuna/vim-header'
	let g:header_field_author       = 'nvxden'
	let g:header_field_author_email = 'nvxden@pm.me'

" colorschemes
Plug 'kristijanhusak/vim-hybrid-material' " Металлический Джейкобс,           прозрачная *
	let g:enable_italic_font = 1
	let g:hybrid_transparent_background = 1
Plug 'sainnhe/sonokai'                    " Самурайская тема,                 прозрачная *
Plug 'sainnhe/gruvbox-material'           " Джейкобс, тёплая,               непрозрачная *
Plug 'whatyouhide/vim-gotham'             " Очень тёмная,                   непрозрачная *
Plug 'danilo-augusto/vim-afterglow'       " Тусклая,                        непрозрачная
Plug 'AlessandroYorba/Alduin'             " Алдуиновская, зеленоватая,      непрозрачная *
Plug 'romainl/Apprentice'                 " Болотная,                       непрозрачная
Plug 'Badacadabra/vim-archery'            " Арч, чёрный фон, тёмно-синяя,   непрозрачная
Plug 'challenger-deep-theme/vim'          " Тёмная, но контраснтная,        непрозрачная *
Plug 'tyrannicaltoucan/vim-deep-space'    " Космическая,                      прозрачная
Plug 'ajmwagar/vim-deus'                  " Grouvbox copy,                  непрозрачная
Plug 'wadackel/vim-dogrun'                " Пришельческая, сине-фиолетовая, непрозрачная *

Plug 'chase/focuspoint-vim'               " Фермерская, зелёная,            непрозрачная
Plug 'jaredgorski/fogbell.vim'            " Будто старый чёрноблеый фильм,  непрозрачная *
Plug 'yorickpeterse/happy_hacking.vim'    " Простая, приятная,              непрозрачная
Plug 'cocopon/iceberg.vim'                " Холодная, ледяная,              непрозрачная *
Plug 'scheakur/vim-scheakur'              " Земляная,                       непрозрачная *
Plug 'w0ng/vim-hybrid'                    " Чёткая, средней тёплости,       непрозрачная
Plug 'nanotech/jellybeans.vim'            " Морская, с водорослями,         непрозрачная
Plug 'jonathanfilip/vim-lucius'           " Серо-светлая, вечерний асфальт, непрозрачная *
Plug 'dikiaap/minimalist'                 " Тёмная земля, простая,          непрозрачная *

Plug 'tomasr/molokai'                     " Похожа на sonokai, но темнее, непрозрачная
Plug 'fmoralesc/molokayo'                 " Как molokai, но светлее,      непрозрачная
Plug 'liuchengxu/space-vim-dark'          " Зеленоватая,                  непрозрачная
Plug 'jaredgorski/SpaceCamp'              " Яркая, зеленоватая,           непрозрачная *
Plug 'jacoborus/tender.vim'               " Приятная, жёлто-оранжевая,    непрозрачная
Plug 'marcopaganini/termschool-vim-theme' " Яркая, простая,               непрозрачная
Plug 'vim-scripts/twilight256.vim'        " Жёлто-зелёная, тёмная,          прозрачная *
Plug 'rakr/vim-two-firewatch'             " Тёмная с кожанным оттенком,   непрозрачная *
Plug 'vim-scripts/wombat256.vim'          " Постная,                      непрозрачная
Plug 'arcticicestudio/nord-vim'           " Яркая,                          прозрачная
Plug 'mhartington/oceanic-next'           " Крабовая,                     непрозрачная *

Plug 'glepnir/oceanic-material'           " Свежая, океаническая с крабами, непрозрачная *
Plug 'rakr/vim-one'                       " Тёмная с фиолетовым, непрозрачная
Plug 'joshdick/onedark.vim'               " То же, что one, но светлее и приятнее, непрозрачная
Plug 'vim-scripts/rdark-terminal2.vim'    " Приятная, зелёно-голубая, прозрачная *
Plug 'junegunn/seoul256.vim'              " Светлая, вебеленная, приятная, непрозрачная
Plug 'AlessandroYorba/Sierra'             " Вишнявая, тёмная, приятная, непрозрачная *
Plug 'sonph/onehalf'                      " 
Plug 'kyoz/purify'                        " 

call plug#end()

filetype on

" Цветовая схема
" colorscheme sonokai
" colorscheme hybrid_material
" colorscheme gruvbox-material
" colorscheme gotham256
" colorscheme dogrun
" colorscheme deep-space
" colorscheme challenger_deep
" colorscheme scheakur
" colorscheme lucius
" colorscheme minimalist
" colorscheme pablo 
" colorscheme pable
" syntax enable

" set termguicolors
let g:alduin_Shout_Dragon_Aspect   = 1
colorscheme alduin







"''''''''''''''''''''''' MAPPINGS ''''''''''''''''''''''''''

" NORMAL AND VISUAL MODE MAPPINGS
" окна (windows)

" перемещение между окнами
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l

" Изменение размеров окон
nnoremap } <C-w>>
nnoremap { <C-w><
nnoremap <leader>w= <C-w>=
nnoremap <leader>w\| <C-w>\|

" Перемещение окон
nnoremap <C-q> <C-w>x
nnoremap <leader>wh <C-w>H
nnoremap <leader>wj <C-w>J
nnoremap <leader>wk <C-w>K
nnoremap <leader>wl <C-w>L

nnoremap <leader>wt <C-w>T
nnoremap <leader>wr <C-w>R
nnoremap <leader>ws <C-w>x

" перемещение между вкладками
nnoremap <C-h> gT
nnoremap <BS>  gT
nnoremap <C-l> gt

" открытие новых окон
nnoremap <C-t> :tabnew<CR>
nnoremap <C-f> :tabnew<space>
nnoremap \     :vnew<CR>
nnoremap \|    :new<CR>

" закрытие окон
nnoremap gq :q!<CR>
nnoremap gQ :qa!<CR>

nnoremap M J
vnoremap M J



" tabs
nnoremap <leader>th :-tabmove<CR>
nnoremap <leader>tl :+tabmove<CR>
nnoremap <leader>tk :0tabmove<CR>
nnoremap <leader>tj :$tabmove<CR>
nnoremap <leader>W  :set wrap!<CR>



" перемещения
map = $
map - ^

nnoremap ]e :set iminsert=0<CR>
nnoremap ]r :set iminsert=1<CR>

" ошибки компилятора
nnoremap <C-m> :cnext<CR>
nnoremap <C-b> :cprev<CR>

" переключение буферов
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>


" операции со всем файлом
nnoremap <C-s> :source .open.vim<CR>
nnoremap <leader>m :w<CR>
nnoremap <leader>M :wa<CR>
nnoremap <leader>dh :%!mdtohtml --html4tags <CR>
nnoremap <leader>dr :e %<CR>
nnoremap <leader>dy :%y"<CR>
nnoremap <leader>dY :%y+<CR>
nnoremap <leader>dm :Man<SPACE>
nnoremap <leader>dd :!!<CR>
nnoremap <leader>dv :e $vimrc<CR>
nnoremap <leader>dV :tabnew $vimrc<CR>
nnoremap <leader>dR :source $vimrc<CR>
nnoremap <silent> <leader>ds :set expandtab<CR>
	\ :exe "1,$!retab -a t2s -t" . &tabstop<CR>
nnoremap <silent> <leader>dt :set noexpandtab<CR>
	\ :exe "1,$!retab -a s2t -t" . &tabstop<CR>
vnoremap <silent> <leader>ds :'<,'>!retab t2s<CR>
vnoremap <silent> <leader>dt :'<,'>!retab s2t<CR>

" make
nnoremap <F2> 1gt:wa<CR>:make build<CR>
nnoremap <F3> 1gt:wa<CR>:make run<CR>
nnoremap <F4> 1gt:wa<CR>:make re<CR>
nnoremap <F5> 1gt:wa<CR>:make test<CR>

nnoremap <leader>b :wa<CR>:make<CR>
nnoremap <leader>B :wa<CR>:make re<CR>
nnoremap <leader>r :wa<CR>:make run<CR>
nnoremap <leader>R :wa<CR>:make rerun<CR>
nnoremap <leader>i :wa<CR>:make run < input<CR>
nnoremap <leader>p :wa<CR>:make clean<CR>




" INSERT MODE MAPPINGS
inoremap <C-l> <delete>
inoremap <C-o> <esc>gUiwe
inoremap <C-d> <esc>:call SwitchLanguage()<CR>a
inoremap JK <esc>S

" чтобы ставить ударения
inoremap <C-v> <C-v>u0301





" "''''''''''''''''''' FILE TYPES COMS '''''''''''''''''''

let javaScript_fold            = 1
let g:python_recommended_style = 0
let g:rust_recommended_style   = 0

" Common
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Function   /\I\i\+\s*(\@=/
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Type       /[a-zA-Z0-9_]\@<!\I\i\+_t[a-zA-Z0-9_]\@!/
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Type       /[a-zA-Z0-9_]\@<!t_\i\+[a-zA-Z0-9_]\@!/
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Identifier /\(#.*\)\@<![a-zA-Z0-9_]\@<!_*[A-Z][a-zA-Z0-9_]\+[a-zA-Z0-9_]\@!/
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Constant   /\(#.*\)\@<![a-zA-Z0-9_]\@<![A-Z][A-Z0-9_]*[a-zA-Z0-9_]\@!/
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Constant   /\(#.*\)\@<![a-zA-Z0-9_]\@<!_\+[A-Z0-9][A-Z0-9_]*[a-zA-Z0-9_]\@!/

au FileType vim nnoremap <leader>e :exec getline('.')<cr>
au FileType vim vnoremap <leader>e :<c-u>exec join(getline("'<", "'>"), "\n")<cr>

" CPP, C
au FileType cpp syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType cpp syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType cpp nnoremap <silent> <buffer> <leader>v :!g++ -fsyntax-only %<CR>
" au FileType cpp syntax keyword Type template typename

au FileType c   syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType c   syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType c   syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType c   nnoremap <silent> <buffer> <leader>v :!gcc -fsyntax-only %<CR>


" PYTHON
au FileType python setlocal foldmethod=indent
au FileType python nnoremap <silent> <buffer> <leader>r :wa<CR>:!python3 main.py<CR>
au FileType python nnoremap <silent> <buffer> <leader>i :wa<CR>:!python3 main.py < input<CR>


" HTML, XML, JSON
au FileType html setlocal foldmethod=indent
au FileType html setlocal tabstop=2
au FileType html setlocal shiftwidth=2

au FileType htmldjango setlocal foldmethod=indent
au FileType htmldjango setlocal tabstop=2
au FileType htmldjango setlocal shiftwidth=2

au FileType xml setlocal foldmethod=indent
au FileType xml setlocal tabstop=2
au FileType xml setlocal shiftwidth=2

au FileType json setlocal foldmethod=indent
au FileType json setlocal tabstop=2
au FileType json setlocal shiftwidth=2

au BufNewFile,BufRead *.pug setlocal foldmethod=indent
au BufNewFile,BufRead *.pug setlocal tabstop=2
au BufNewFile,BufRead *.pug setlocal shiftwidth=2


" RUST
au FileType rust nnoremap <silent> <buffer> <leader>r :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run<CR>
au FileType rust nnoremap <silent> <buffer> <leader>R :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run --release<CR>
au FileType rust nnoremap <silent> <buffer> <leader>i :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run < input<CR>
au FileType rust nnoremap <silent> <buffer> <leader>b :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build<CR>
au FileType rust nnoremap <silent> <buffer> <leader>B :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build --release<CR>
au FileType rust nnoremap <silent> <buffer> <leader>p :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo clean<CR>
au FileType rust nnoremap <silent> <buffer> <leader>v :wa<CR>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo check<CR>
au FileType rust let g:AutoPairs = { "[" : "]", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''" }
au FileType rust compiler! cargo












"'''''''''''''''' MAPPINGS (DESCRIPTION) '''''''''''''''''''
" NORMAL MDOE

" !      # вызов фильтра
" @      # исполнить макрос
" #      # то же, что *, но в обратном порядке
" $      # в конец строки
" %      # перенистись к парному символу
" ^      # к началу строку (первый непробельный символ)
" &      # (???) найти предыдущую замену (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" *      # найти тот же идентификатор, что под курсором
" (      # предложение назад (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" )      # предложение вперяд (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" 0      # в начало строке (в самое-самое)
" -      # USE ^ # k^ (ОПРОБОВАТЬ)
" _      # ^
" =      # USE $
" +      # j^ (ОПРОБОВАТЬ)

" ]  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" [  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" }  # параграф назад
" {  # параграф вперёд
" \  # US :vnew<CR>
" |  # US :new<CR>
" /  # поиск по файлу
" ?  # поиск по файлу (назад)

" q       # записать макрсом
" Q       # переход в режим Ex (ОПРОБОВАТЬ)
" w       # к началу следующего слова
" W       # к началу следующего СЛОВА
" e       # к концу следующего слова
" E       # к концу следующего СЛОВА
" r<sym>  # заменить символ под курсором
" R       # войти в режим замены
" t<sym>  # перейти к символу перед искомым
" T<sym>  # перейти к символы перед искомым (поиск назад)
" y       # КОМАНДА С ПРОДОЛЖЕНИЕМ (см. отдельно)
" Y       # скопиротавь текущую строку
" u       # undo
" U       # МОЖНО ПЕРЕНАЗНАЧИТЬ
" i       # перейти в режим вставки
" I       # перейти в режим вставки, переместившись в начало строки
" o       # перейти в режим вставки, вставить новую строку после
" O       # перейти в режим вставки, вставить новую строку перед
" p       # вставить из буфера обмена после
" P       # вставить из буфера обмена перед
" a       # перейти в режим вставки, после тещего символа
" A       # перейти в режим вставки, переместившись в конец строки
" s       # перейти в режим вставки, удалив символ под курсором
" S       # перейти в режим вставки, удалив строку под курсором
" d<diap> # удалить диапазон
" D       # удалить всё начиная с курсора до конца строки
" f<sym>  # перейти к символу в текущей строке
" F<sym>  # перейти к символу в текущей строке (поиск назад)
" g       # КОМАНДА С ПРОДОЛЖЕНИЕМ (см. отдельно)
" G       # в конец файла
" h       # влево
" H       # перейти в окно влево
" j       # вниз
" J       # US перейти на окно вниз
" k       # вверх
" K       # перейти в окно вверх
" l       # вправо
" L       # перейти в окно вправо
" ;       # повторный поиск в строке (f,F,t,T)
" '       # перейти к отметке
" "       # использовать регистр
" z       # КОМАНДА С ПРОДОЛЖЕНИЕМ (см. отдельно)
" Z       # ???
" x       # удалить символ под курсором
" X       # удалить символ перед курсором
" c<diap> # перейти в режим вставки, удалив диапазон
" C       # перейти в режим вставки, удалив всё начиная с курсора до $
" v       # перейти в визуальный режим
" V       # перейти в визуальный режим (выделение строк)
" b       # к началу предыдущего слова
" B       # к началу предыдущего СЛОВА
" n       # следующий успешный поиск /
" N       # предыдущий успешный поиск
" m       # КОМАНДА С ПРОДОЛЖЕНИЕМ (см. отдельно)
" M       # US совместить две строки
" ,       # <leader>
" <       #
" .       # повторить последнее редактирование
" >       #

" key 'g':
" <N>gt    # to N tab
" gt       # tabnext
" gT       # tabprev
" gg       # to first line
" gv       # prev visual
" g&       # last :s for all lines
" g8       # print hex value of character under cursor
" ge       # US :Ag ""<left>
" gq       # US :q!<CR>
" gQ       # US :wq<CR>
" gi       # US :vnew<CR>:FZF<CR>
" gh       # US :new<CR>:FZF<CR>
" go       # US :FZF<CR>
" gz       # US :tabnew<CR>:FZF<CR>
" gs       # US YcmCompleter GoToSymbol
" gd       # US YcmCompleter GoTo
" gp       # US :TabberSelectLastActive<CR>
" g<left>  # :TabberShiftLeft<CR>
" g<right> # :TabberShiftRight<CR>

" <C-q>   # <C-w>x
" <C-w>   # КОМАНДА С ПРОДОЛЖЕНИЕМ (управление окнами)
" <C-e>   # переместиться на строку вниз
" <C-r>   # redo
" <C-t>   # US :tabnew<CR>
" <C-y>   # строку вверх
" <C-u>   # полэкрана вверх
" <C-i>   # на следующую позицию
" <C-o>   # на предыдущую позицию
" <C-p>   # fzf (ОСВОИТЬ)
" <C-a>   # Увеличение числа на один
" <C-s>   # US :source .open.vim<CR>
" <C-d>   # на экран ниже
" <C-f>   # US :tabnew<SPACE>
" <C-g>   # показать информацию о файле (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-h>   # US gT
" <C-j>   # переместить строку вниз
" <C-k>   # переместить строку вверх
" <C-l>   # US gt
" <C-z>   # остановить программу
" <C-x>   # US Color-Picker
" <C-c>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-v>   # визуальный блок
" <C-b>   # US :cprev
" <C-n>   # US :NERDTree
" <C-m>   # US :cnext

" <F1>   # :help
" <F2>   # :make build
" <F3>   # :make run
" <F4>   # :make re
" <F5>   # :make test
" <F6>   # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F7>   # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F8>   # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F9>   # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F10>  # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F11>  # (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <F12>  # (МОЖНО ПЕРЕНАЗНАЧИТЬ)


" <leader>q ???
" <leader>Q ???
" <leader>w US h -> <C-w>H, j -> <C-w>J, k -> <C-w>K, l -> <C-w>L, t -> <C-w>T
" <leader>W US SwitchWrap
" <leader>e US easy-motion к конца слова после, py: Ju run visual
" <leader>E US easy-motion к конца СЛОВА после
" <leader>r US make run; rust: run, py: !python3 main.py
" <leader>R US make re;  rust: run --release
" <leader>t US
"              h -> :-tabmove
"              l -> :+tabmove
"              k -> :0tabmove
"              j -> :$tabmove
" <leader>T ???
" <leader>y ???
" <leader>Y ???
" <leader>u ???
" <leader>U ???
" <leader>i US make run < input; rust: run < input, py: !python3 main.py < input
" <leader>I ???
" <leader>o US py: JupyterRunFile
" <leader>O ???
" <leader>p US make clean; rust: cargo clean
" <leader>P ???
" <leader>a ???
" <leader>A ???
" <leader>s US easy-motion
" <leader>S ???
" <leader>d r -> reload; y -> yank; h -> md2html; c: n -> norminette; c: f -> fmt42,
"           n -> norminette m -> Man; c, cpp: c -> Cppman; s -> tab to spaces;
"           t -> spaces to tabs; d -> :!!<CR>; v -> :tabnew $vimrc<CR>
" <leader>D ???
" <leader>f US easy-motion
" <leader>F US easy-motion
" <leader>g (GitGutter): u,s,q
	" <leader>gq :GitGutterQuickFix \| copen<CR>
	" <leader>gu :GitGutterUndoHunk<CR>
	" <leader>gs :GitGutterStageHunk<CR>
	" <leader>gp :GitGutterPreviewHunk<CR>
	" <leader>gf :GitGutterFold<CR>
	" <leader>gh :GitGutterLineHighlightsToggle<CR>
" <leader>G ???
" <leader>h ???
" <leader>H ???
" <leader>j US easy-motion
" <leader>J ???
" <leader>k US easy-motion
" <leader>K ???
" <leader>l US reload file
" <leader>L ???
" <leader>z ???
" <leader>Z ???
" <leader>x py: Ju run cell
" <leader>X ???
" <leader>c US comment plugin (h -> c2h)
" <leader>C ???
" <leader>v US rust: check
" <leader>V ???
" <leader>b US make; rust: build
" <leader>B US rust: build --release
" <leader>n ???
" <leader>N ???
" <leader>m US: :w<CR>
" <leader>M US: :wa<CR>





" INSERT MODE

" <C-q>   # h1
" <C-w>   # удалить слово перед курсором
" <C-e>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-r>   # вставить из регистра
" <C-t>   # сделать таб в начале строки (ОСВОИТЬ)
" <C-y>   # emmet
" <C-u>   # удалить строку
" <C-i>   # сделать таб (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-o>   # USE преобразовать слово к верхнему регистру
" <C-p>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-a>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-s>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-d>   # US изменить язык
" <C-f>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-g>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-h>   # удалить символ перед курсором (backspace)
" <C-j>   # US раскрыть сниппет
" <C-k>   # вставить спецсимвол
" <C-l>   # US удалить символ после курсора (del)
" <C-z>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-x>   # US color-picker
" <C-c>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-v>   # поставить ударение (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-b>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-n>   # вимовское автодополнение (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-m>   # то же, что ENTER (МОЖНО ПЕРЕНАЗНАЧИТЬ)





"-------------------------- DOCS -------------------------
" " pattern
" :set [no]ignorecase
" :set ignorecase smartcase

" " [don't] ignore case for one pattern
" /\cword
" /\Cword

" " offset (next/prev string)
" /pattern/1
" /pattern/-1
" ?pattern?1
" ?pattern?-1

" " move cursor on the end of match
" /pattern/e

" " move cursor on the Nth character of pattern
" /pattern/b+4

" " repeat: no remove offset, with remove
" /
" //

" " vim pattern | python-pattern
" /a*             /a*
" /a.             /a.
" /\(ab\)         /(ab)
" /a\+            /a+
" /folders\=      /folders?
" /ab\{3,5}       /ab{3,5}
" /ab\{-1,3}      ??? " minimal match
" /a.\{-}b        ??? " find "axb" in axbaxb
" /foo\|bar       /foo|bar
" /[a-z]          /[a-z]

" " vim-special
" /a\@=           " find 'a' but not include in match
" /a\@!           " not find 'a'
" /a\@<=          " find 'a' just before puttern
" /a\@123<=       " find 'a' just before putter (look back 123 bytes)
" /a\@<!          " not find 'a' just before puttern


" " special symbols
" \e	<Esc>
" \t	<Tab>
" \r	<CR>
" \b	<BS>

" " ranges
" \s whitespace character:       <Space> and <Tab>  */\s*
" \S non-whitespace character;   not <Space> and not <Tab>
" \d digit:                      [0-9]         */\d*
" \D non-digit:                  [^0-9]        */\D*
" \x hex digit:                  [0-9A-Fa-f]   */\x*
" \X non-hex digit:              [^0-9A-Fa-f]  */\X*
" \o octal digit:                [0-7]         */\o*
" \O non-octal digit:            [^0-7]        */\O*
" \w word character:             [0-9A-Za-z_]  */\w*
" \W non-word character:         [^0-9A-Za-z_] */\W*
" \h head of word character:     [A-Za-z_]     */\h*
" \H non-head of word character: [^A-Za-z_]    */\H*
" \a alphabetic character:       [A-Za-z]      */\a*
" \A non-alphabetic character:   [^A-Za-z]     */\A*
" \l lowercase character:        [a-z]         */\l*
" \L non-lowercase character:    [^a-z]        */\L*
" \u uppercase character:        [A-Z]         */\u*
" \U non-uppercase character:    [^A-Z]        */\U*

" " classes of characters
" \i	identifier characters		'isident'
" \I	like \i, excluding digits
" \k	keyword characters			'iskeyword'
" \K	like \k, excluding digits
" \p	printable characters		'isprint'
" \P	like \p, excluding digits
" \f	file name characters		'isfname'
" \F	like \f, excluding digits






" CTAGS
"
" Чтобы сгенерировать файл тегов
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -o .ctags
"
" Чтобы добавить теги к текущей сессии вима
" :set tags+=.ctags
"
" В open.vim можно добавить:
" !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -o .ctags
" :set tags+=.ctags



" Чтобы включить проверку орфографии:
" set spell spelllang=ru
" z= - показать возможные исправления
" ]s - к следующей ошибке
" [s - к предыдущей ошибке
" выключить: set nospell



" CTRL-] - перейти на определение тега(в новом буфере)
" CTRL-t - возвратиться назад по стеку вызовов
" [i - показать первую строку содержащую слово под курсором, поиск с начала файла.
" ]i - показать первую строку содержащую слово под курсором, поиск с текущей позиции.
" [I - показать все вхождения данного тега
" ]I - показать все вхождения данного тега с текущей позиции курсора
" [ CTRL-I - перейти на определение тега(в новом буфере)
" ] CTRL-I - перейти на определение тега(в новом буфере) с текущей позиции курсора
" CTRL-W i - открыть новое окно с курсором на строке ключевого слова.



" Клавиши которые стит записать:
" Командный режим:
"	 Прокрутка:
" 		<С-e> - 	на одну строку вниз
" 		<C-y> - 	на одну строку вврех
" 		<C-d> - 	на пол экрана вниз
" 		<C-u> - 	на пол экрана вврех
" 		<C-f> - 	на экран вниз
" 		<C-b> - 	на экран вврех
" 	Прочее:
" 		,          повторить поииск в другую сторону
" 		<C-w><     уменьшить ширину окна
" 		<C-w>>     увеличить ширину окна
" 		<C-w>-     уменьшить высоту окна
" 		<C-w>+     увеличить высоту окна
" 		<C-w>H     переместить окно влево
" 		<C-w>=     сделать все окна равными по размеру
" 		<C-w>J     вниз
" 		<C-w>K     вверх
" 		<C-w>L     вправо
" Режим вставки:
" 	Удаление:
" 		<C-h> - 	удалить символ слева от курсора;
" 		<C-w> - 	удалить слово слева от курсора;
" 		<C-u> - 	удалить текст слева от курсора;
"	Регистры:
"		<C-r>N - 	ставить из регистра N
"	Прочее:
"		<C-o> - 	перейти в командный режим на одну команду
"		<C-r>=expr - 	ставить результат expr(<C-r>=2*2->4)
"
"	Сохранение содержимого в новый файл: save filename
