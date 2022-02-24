" ########################################################################## "
" ################################# COMMON ################################# "
" ########################################################################## "
"
" Marks:
"  V - begin of file
"  p - plugins
"  m - mapings
"  f - filetypes
"  d - docs
"

set encoding=utf-8
set ttimeoutlen=0 " чтобы не было задержек

set autoread      " автоматически загружать внешние изменения файла
set nolist        " отображать симоволы табуляции
set nohlsearch    " no highlight search result after <cr>
set incsearch     " highlight search result while typing
set ignorecase    " ignore case; neccessary for smartcase
set smartcase     " smart case while searching
set number        " нумерование строк
set rnu           " relative number

set scrolloff=10
" set scrollback=20000

set tabstop=4
set softtabstop=0
set shiftwidth=4
set foldmethod=syntax " Может замедлять загрузку больших файлов
set foldlevelstart=99
set colorcolumn=81

set autoindent
set smartindent
set smarttab
set nowrap
set noswapfile
set splitright
set splitbelow

set mousehide
set mouse=a
set novisualbell
set showtabline=1 " set foldcolumn=1

set keymap=russian-dictor
set iminsert=0
set imsearch=0



fun! SwitchLanguage()
	if &iminsert == 0
		set iminsert=1
	else
		set iminsert=0
	endif
endfunction

fun! s:StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
	write
endfun

autocmd BufWrite <buffer> :call s:StripTrailingWhitespaces()
autocmd BufRead if &buftype == "quickfix" <buffer> nnoremap o <cr> endif

let g:mapleader=','
if has('macunix')
	let g:python3_host_prog = '/usr/local/bin/python3'
endif

if exists('$TMUX')
	let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
	let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
else
	let &t_SI .= "\e[=1c"
	let &t_EI .= "\e[=2c"
endif







" ########################################################################## "
" ################################ PLUGINS ################################# "
" ########################################################################## "

call plug#begin('~/.config/nvim/autoload/plugged')


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ autocomplete ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" does't slow down
	" if !has('macunix')
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
		nnoremap [g <Plug>(coc-diagnostic-prev)
		nnoremap ]g <Plug>(coc-diagnostic-next)
		nnoremap gG :call CocAction("diagnosticToggle")<cr>

		" GoTo code navigation.
		nnoremap gd :call CocAction("jumpDefinition")<cr>
		nnoremap gc :call CocAction("jumpDeclaration")<cr>
		nnoremap gy :call CocAction("jumpTypeDefinition")<cr>
		nnoremap gI :call CocAction("jumpImplementation")<cr>
		nnoremap gr :call CocAction("jumpReferences")<cr>
		nnoremap gR :call CocAction("rename")<cr>
		nnoremap gS :call CocActionAsync("diagnosticInfo")<cr>
		nnoremap gD :call <SID>ShowDocumentation()<cr>

		function! s:ShowDocumentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			elseif (coc#rpc#ready())
				call CocActionAsync('doHover')
			else
				execute '!' . &keywordprg . " " . expand('<cword>')
			endif
		endfunction
	" endif

	" Plug 'neovim/nvim-lspconfig'

" lua << EOF
" require'lspconfig'.pyright.setup{}
" EOF


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ widgets ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	Plug 'vim-airline/vim-airline'
	" Plug 'powerline/powerline'

	" does't slow down
	Plug 'scrooloose/nerdcommenter' " комментирование
		nmap <leader>c= ,c$

	" does't slow down
	Plug 'scrooloose/nerdtree' " просмотр файловой системы
			map <C-n> :NERDTreeToggle<cr>
			let NERDTreeIgnore=['\~$', 'target', 'trg', '*.o', 'build', '__pycache__']
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

	" does't slow down
	Plug 'Xuyuanp/nerdtree-git-plugin'
		 let g:NERDTreeGitStatusUseNerdFonts = 1
		 let g:NERDTreeGitStatusIndicatorMapCustom = {
 \			'Modified'  :'✹',
 \			'Staged'    :'✚',
 \			'Untracked' :'✭',
 \			'Renamed'   :'➜',
 \			'Unmerged'  :'═',
 \			'Deleted'   :'✖',
 \			'Dirty'     :'✗',
 \			'Ignored'   :'☒',
 \			'Clean'     :'✔︎',
 \			'Unknown'   :'?',
 \			}

	" Plug 'jistr/vim-nerdtree-tabs'

	" does't slow down
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

	" does't slow down
	Plug 'PhilRunninger/nerdtree-visual-selection'

	" does't slow down
	Plug 'fweep/vim-tabber'
		 let g:tabber_filename_style = 'filename'
		 nnoremap <leader>tt :TabberSelectLastActive<cr>

	" does't slow down
	if !has('macunix')
		Plug 'ryanoasis/vim-devicons'
			 set guifont=DroidSansMono\ Nerd\ Font\ 10
			 let g:airline_powerline_fonts = 1
	 endif

	" " Разноцветная подсветка скобок
	" does't slow down
	Plug 'luochen1990/rainbow'
		let g:rainbow_active = 1
		let g:rainbow_conf = {
	\		'separately': {
	\			'html':     0,
	\			'nerdtree': 0,
	\     'cmake':    0
	\		}
	\	}

	" Smooth scroll
	" can slow down (with pulse)
	" Plug 'terryma/vim-smooth-scroll'
		" nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 4, 3)<cr>
		" nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 4, 3)<cr>

	" can slow down (with smooth)
	" Plug 'inside/vim-search-pulse'
    " let g:vim_search_pulse_duration = 50

	" Intresting start screen
	" does't slow down
	Plug 'mhinz/vim-startify'

	" does't slow down
	Plug 'junegunn/gv.vim'

	Plug 'junegunn/goyo.vim'
		let g:goyo_width  = 83
		let g:goyo_linenr = 1
		let g:goyo_height = '93%'
		nnoremap <leader>z :Goyo<cr>0
		nnoremap <leader>Z :Goyo<cr>:Goyo<cr>0

		fun! s:goyo_enter()
			hi EndOfBuffer ctermfg=236
		endfun

		fun! s:goyo_leave()
			call tabber#init()
			set tabline=%!tabber#TabLine()
		endfun

		au! User GoyoEnter nested call s:goyo_enter()
		au! User GoyoLeave nested call s:goyo_leave()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ editing ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" does't slow down
	Plug 'SirVer/ultisnips'
		 let g:UltiSnipsExpandTrigger="<c-j>"
		 let g:UltiSnipsJumpForwardTrigger="<tab>"
		 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
		 let g:UltiSnipsEditSplit="vertical"

	" does't slow down
	Plug 'tpope/vim-surround'
		" cs'" - заменить ' на " ( можно указывать любые скобки: `'[{(<' )
		" yss) - обернуть данную строку в скобки ()
		" ds(  - удалить пару скобок ()
		" ct<div> - изменить тег на <div>
		" в команде yss вместо последней s можно исполизовать сочетания типа iw,aw...

	" does't slow down

	Plug 'jiangmiao/auto-pairs'
		let g:AutoPairs = { "[" : "]", "{" : "}", "'":"'", '"':'"', "`":"`",
	    \                 '```':'```', '"""':'"""', "'''":"'''" }
		let g:AutoPairsShortcutToggle     = ''
		let g:AutoPairsShortcutFastWrap   = ''
		let g:AutoPairsShortcutJump       = ''
		let g:AutoPairsShortcutBackInsert = ''
		nnoremap <leader>P :call AutoPairsToggle()<cr>

	" does't slow down
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

	" does't slow down
	Plug 'matze/vim-move'
		nmap <C-j> <Plug>MoveLineDown
		nmap <C-k> <Plug>MoveLineUp
		vmap <C-j> <Plug>MoveBlockDown
		vmap <C-k> <Plug>MoveBlockUp

	" does't slow down
	Plug 'maxbrunsfeld/vim-yankstack'
		let g:yankstack_map_keys = 0
		let g:yankstack_yank_keys = ['y']
		nmap <A-p> <Plug>yankstack_substitute_older_paste
		xmap <A-p> <Plug>yankstack_substitute_older_paste
		imap <A-p> <Plug>yankstack_substitute_older_paste
		nmap <A-i> <Plug>yankstack_substitute_newer_paste
		xmap <A-i> <Plug>yankstack_substitute_newer_paste
		imap <A-i> <Plug>yankstack_substitute_newer_paste

	" does't slow down
	Plug 'mattn/emmet-vim'
		let g:user_emmet_install_global = 0
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

	" Plug 'reconquest/vim-pythonx'

	" does't slow down
	Plug 'KabbAmine/vCoolor.vim' " color-picker <Alt+c>
		let g:vcoolor_map = '<C-x>'

	" does't slow down
	Plug 'tpope/vim-repeat'

	" Новый текстовый объект, определённый по уровню отступов
	" does't slow down
	Plug 'michaeljsmith/vim-indent-object'

	" does't slow down
	Plug 'nvxden/vim-pretty-comments'
		let g:nvxvpc_default_margin   = 1
		let g:nvxvpc_default_closedef = 1

		let g:nvxvpc_styles = [
			\ [ "light", {
			\ 		'margin' : 1,
			\ 		'filler' : '~',
			\ 		'type'   : 'alt',
			\ 		'align'  : 'center',
			\ } ],
			\
			\ [ "bold", {
			\ 		'margin' : 1,
			\ 		'filler' : '=',
			\ 		'type'   : 'alt',
			\ 		'align'  : 'center',
			\ } ],
			\
			\ [ "wrapped", {
			\ 		'type'   : 'alt',
			\ 		'header' : 1,
			\ 		'footer' : 1,
			\ 		'filler' : '~',
			\ } ],
			\
			\ [ "wrapped_light", {
			\     'extends'   : 'wrapped',
			\ 		'fillleft'  : 0,
			\ 		'fillright' : 0,
			\ 		'padding'   : 5,
			\ } ],
			\
			\ [ "wrapped_bold", {
			\ 		'extends' : 'wrapped',
			\ 		'filler'  : '=',
			\ } ],
		\]

		nnoremap <leader>pc :call nvxvpc#insert_comment()<cr>
		nnoremap <leader>pl :call nvxvpc#insert_comment('light')<cr>
		nnoremap <leader>pb :call nvxvpc#insert_comment('bold')<cr>
		nnoremap <leader>pw :call nvxvpc#insert_comment('wrapped_light')<cr>
		nnoremap <leader>pW :call nvxvpc#insert_comment('wrapped_bold')<cr>
		nnoremap <leader>pR :call nvxvpc#reload()<cr>

		" let g:nvxvpc_default_settings = {
			" \ 'filler' : '%',
			" \ 'align'  : 'right',
		" \}
		" let g:nvxvpc_default_filler  = '-'
		" let g:nvxvpc_default_bound   = 2
		" let g:nvxvpc_default_margin  = 2
		" let g:nvxvpc_default_padding = 3
		" let g:nvxvpc_cpp_filler = '~'
		" let g:nvxvpc_python_filler = '#'
		" let g:nvxvpc_python_closedef = 1



" ~~~~~~~~~~~~~~~~~~~~~~~~~ moving and navigation ~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" does't slow down
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

		let g:fzf_source = 'find . -type f -not -path "*.git/*" ' .
		                 \ '-not -path "./build/*" '              .
										 \ '-not -path "*/__pycache__/*" '      .
										 \ '-not -name "*.[oda]" '                .
										 \ '-not -name "main" | '                 .
		                 \ 'sed -e "s/\.\///" | sort -nr'

		let g:fzf_options = {
		\ 'sink': 'e',
		\ 'source': fzf_source,
		\ 'window': {'width': 0.9, 'height': 0.7}
		\}

		nnoremap gi :vnew<cr>:call fzf#run(g:fzf_options)<cr>
		nnoremap gh :new<cr>:call fzf#run(g:fzf_options)<cr>
		nnoremap gz :tabnew<cr>:call fzf#run(g:fzf_options)<cr>
		nnoremap go :call fzf#run(g:fzf_options)<cr>

	" does't slow down
	Plug 'rking/ag.vim'
		nnoremap ge :Ag<SPACE>""<left>

	" does't slow down
	Plug 'easymotion/vim-easymotion'
		map <Leader> <Plug>(easymotion-prefix)
		" ,s<char> - Найти символ

	" " Plug 'kien/ctrlp.vim'

	Plug 'terryma/vim-multiple-cursors'
		let g:multi_cursor_use_default_mapping = 0
		let g:multi_cursor_start_word_key      = '<leader>mb'
		let g:multi_cursor_select_all_word_key = '<leader>ma'
		let g:multi_cursor_start_key           = '<leader>ms'
		let g:multi_cursor_select_all_key      = '<leader>mA'
		let g:multi_cursor_next_key            = '<C-n>'
		let g:multi_cursor_prev_key            = '<C-p>'
		let g:multi_cursor_skip_key            = '<C-m>'
		let g:multi_cursor_quit_key            = '<Esc>'
		" nnoremap ms :MultipleCursorsFind<Space>
		" vnoremap ms :MultipleCursorsFind<Space>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ technology ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" does't slow down
	Plug 'tikhomirov/vim-glsl' " Подсветка синтаксиса для GLSL
		autocmd! BufNewFile,BufRead *.vs,*.fs,*.frag set ft=glsl

	Plug 'Fymyte/rasi.vim'  " Syntax hightlight for rasi (rofi) files
	Plug 'elkowar/yuck.vim' " Syntax hightlight for yack (eww) files

	let g:python3_host_prog = '/usr/local/bin/python3'

	if !has('macunix')
		packadd! vimspector

		fun! AddVimspectorMappings()
			nnoremap q :call VimspectorReset()<cr>
			nnoremap p :call vimspector#Pause()<cr>
			nnoremap S :call vimspector#Stop()<cr>
			nnoremap r :call vimspector#Restart()<cr>
			nnoremap t :call vimspector#ToggleBreakpoint()<cr>
			nnoremap T :call vimspector#ToggleConditionalBreakpoint()<cr>
			nnoremap s :call vimspector#StepOver()<cr>
			nnoremap I :call vimspector#StepInto()<cr>
			nnoremap o :call vimspector#StepOut()<cr>
			nnoremap c :call vimspector#Continue()<cr>
			nnoremap C :call vimspector#RunToCursor()<cr>
			nnoremap U :call vimspector#UpFrame()<cr>
			nnoremap D :call vimspector#DownFrame()<cr>
			nnoremap e :call vimspector#BalloonEval()<cr>
		endfun

		fun! RemoveVimspectorMappings()
			nunmap q
			nunmap p
			nunmap S
			nunmap R
			nunmap t
			nunmap T
			nunmap s
			nunmap I
			nunmap o
			nunmap c
			nunmap C
			nunmap U
			nunmap D
			nunmap e
		endfun

		fun! VimspectorLaunch()
			call AddVimspectorMappings()
			call vimspector#Launch()
		endfun

		fun! VimspectorReset()
			call RemoveVimspectorMappings()
			call vimspector#Reset()
		endfun

		nnoremap <M-t> :call vimspector#ToggleBreakpoint()<cr>
		nnoremap <leader>vv :call VimspectorLaunch()<cr>
		nnoremap <leader>vV :call VimspectorReset()<cr>
		nnoremap <leader>vp :call vimspector#Pause()<cr>
		nnoremap <leader>vc :call vimspector#Continue()<cr>
		nnoremap <leader>vs :call vimspector#Stop()<cr>
		nnoremap <leader>vr :call vimspector#Restart()<cr>
		nnoremap <leader>vt :call vimspector#ToggleBreakpoint()<cr>
		nnoremap <leader>vT :call vimspector#ToggleConditionalBreakpoint()<cr>
		nnoremap <leader>vC :call vimspector#RunToCursor()<cr>
		nnoremap <leader>vo :call vimspector#StepOver()<cr>
		nnoremap <leader>vi :call vimspector#StepInto()<cr>
		nnoremap <leader>vO :call vimspector#StepOut()<cr>
		nnoremap <leader>vu :call vimspector#UpFrame()<cr>
		nnoremap <leader>vd :call vimspector#DownFrame()<cr>
		nnoremap <leader>ve :call vimspector#BalloonEval()<cr>

		" Каждая команда начинается с <Plug>Vimspector, например
		" <Plug>VimspectorStop (но здесь опущено для краткости)
		" Continue                    # When debugging, continue. Otherwise
		"                             # start debugging. vimspector#Continue()

		" Stop                        # Stop debugging. vimspector#Stop()

		" Restart                     # Restart debugging with the same
		"                             # configuration. vimspector#Restart()

		" Pause                       # Pause debuggee. vimspector#Pause()

		" ToggleBreakpoint            # Toggle line breakpoint on the current
		"                             # line. vimspector#ToggleBreakpoint()

		" ToggleConditionalBreakpoint # Toggle conditional line breakpoint or
		"                             # logpoint on the current line.
		"                             # vimspector#ToggleBreakpoint( { trigger
		"                             # expr, hit count expr } )

		" AddFunctionBreakpoint       # Add a function breakpoint for the
		"                             # expression under cursor
		"                             # vimspector#AddFunctionBreakpoint(
		"                             # '<cexpr>' )

		" RunToCursor                 # Run to Cursor vimspector#RunToCursor()

		" StepOver                    # Step Over vimspector#StepOver()

		" StepInto                    # Step Into vimspector#StepInto()

		" StepOut                     # Step out of current function scope
		"                             # vimspector#StepOut()

		" UpFrame                     # Move up a frame in the current call
		"                             # stack vimspector#UpFrame()

		" DownFrame                   # Move down a frame in the current call
		"                             # stack vimspector#DownFrame()

		" BalloonEval                 # Evaluate expression under cursor (or
		"                             # visual) in popup internal
	endif


	" does't slow down
	Plug 'jupyter-vim/jupyter-vim'
		let g:jupyter_mapkeys   = 0
		" Run current file
		au FileType python nnoremap <silent> <buffer> <leader>C :JupyterConnect<cr>
		au FileType python nnoremap          <buffer> <leader>o :JupyterRunFile<cr>

		" Change to directory of current file
		" au FileType python map <silent> <buffer> <leader>d :JupyterCd %:p:h<cr>
		" Send a selection of lines
		au FileType python nnoremap <silent> <buffer> <leader>x  :JupyterSendCell<cr>
		au FileType python nnoremap <silent> <buffer> <leader>E  :JupyterSendRange<cr>
		au FileType python nmap     <silent> <buffer> <leader>e  V<leader>e<esc>
		au FileType python vnoremap <silent> <buffer> <leader>e  :JupyterSendRange<cr>
		au FileType python nnoremap <buffer> <silent> <leader>cc :JupyterConnect<cr>
		au FileType python nnoremap <buffer> <silent> <leader>U  :JupyterUpdateShell<cr>

		" Debugging maps
		au FileType python nnoremap <buffer> <silent> <leader>b :PythonSetBreak<cr>

	" does't slow down
	Plug 'airblade/vim-gitgutter'
		let g:gitgutter_map_keys = 0
		" set signcolumn=yes " always have sign column
		nnoremap <silent> <leader>gq :GitGutterQuickFix \| copen<cr>
		nnoremap <silent> <leader>gu :GitGutterUndoHunk<cr>:w<cr>:GitGutterAll<cr>
		nnoremap <silent> <leader>gs :GitGutterStageHunk<cr>:w<cr>:GitGutterAll<cr>
		nnoremap <silent> <leader>gp :GitGutterPreviewHunk<cr>
		nnoremap <silent> <leader>gf :GitGutterFold<cr>
		nnoremap <silent> <leader>gh :GitGutterLineHighlightsToggle<cr>
		nnoremap ]c :GitGutterNextHunk<cr>
		nnoremap [c :GitGutterPrevHunk<cr>
		au BufWrite * :GitGutterAll

	" does't slow down
	Plug 'tpope/vim-fugitive'

	" Plug 'dbeniamine/cheat.sh-vim'

	" " SQL
	Plug 'joereynolds/SQHell.vim'
		au FileType sql,mysql nnoremap <buffer> <leader>cc
			\ :r !mysql -unvx -ppassword -h localhost <<< `cat %` \| column -t<cr>
		au FileType sql,mysql nnoremap <buffer> <leader>e :SQHExecute<cr>
		au FileType sql,mysql nnoremap <buffer> <leader>E :SQHExecute!
		au FileType sql,mysql vnoremap <buffer> <leader>e :SQHExecute<cr>

		let g:sqh_provider       = 'mysql'
		let g:sqh_results_output = 'smart'
		let g:sqh_connections    = {
\			'default': {
\				'user':     'nvx',
\				'password': 'password',
\				'host':     'localhost',
\				'database': 'film'
\			}
\		}

	Plug 'fladson/vim-kitty'


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ languages ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" Plug 'rust-lang/rust.vim'

	" SCHOOL 21
	" does't slow down
	if !has('macunix')
		Plug 'cacharle/c_formatter_42.vim'
			au FileType           c   nnoremap <silent> <buffer> <leader>dn :w<cr>:Norminette<cr>
			au FileType           c   nnoremap <silent> <buffer> <leader>df :CFormatter42<cr>:w<cr>
			au FileType           c   vnoremap <silent> <buffer> <leader>df :'<,'>!c_formatter_42<cr>
			au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>dn :w<cr>:NorminetteHeader<cr>
			au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>df :CFormatter42<cr>:w<cr>
			au BufNewFile,BufRead *.h vnoremap <silent> <buffer> <leader>df :'<,'>!c_formatter_42<cr>
	endif

	" does't slow down
	Plug 'pbondoer/vim-42header'
		au FileType           c   nnoremap <silent> <buffer> <leader>dh :Stdheader<cr>
		au BufNewFile,BufRead *.h nnoremap <silent> <buffer> <leader>dh :Stdheader<cr>

	" Переключение между заголовочными и исходными файлами
	" does't slow down
	Plug 'linluk/vim-c2h'
		" ,ch

	" Plug 'numirias/semshi' " syntax highlight for python

	Plug 'dart-lang/dart-vim-plugin'
		au FileType dart nnoremap <silent> <buffer> <leader>df :w<cr>:!dart format %<cr>
		au FileType dart vnoremap <silent> <buffer> <leader>df :'<,'>!dart format<cr>


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ accessory ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	" does't slow down
	Plug 'aserebryakov/vim-todo-lists'
		let g:VimTodoListsUndoneItem = '- [ ]'
		let g:VimTodoListsDoneItem   = '- [X]'
		let g:VimTodoListsMoveItems  = 1

		" VimTodoListsCreateNewItemAbove - creates a new item in a line above cursor
		" VimTodoListsCreateNewItemBelow - creates a new item in a line below cursor
		" VimTodoListsCreateNewItem      - creates a new item in current line
		" VimTodoListsGoToNextItem       - go to the next item
		" VimTodoListsGoToPreviousItem   - go to the previous item
		" VimTodoListsToggleItem         - toggles the current item
		" VimTodoListsIncreaseIndent     - increases the indent of current line
		" VimTodoListsDecreaseIndent     - decreases the indent of current line

		" Default mapping
		" j           - go to next item
		" k           - go to previous item
		" O           - create new item above the cursor
		" o           - create new item below the cursor
		" <Space>     - toggle current item
		" <cr>        - create new item in insert mode
		" <Tab>       - increases the indent of current (or selected) line(s)
		" <Shift-Tab> - decreases the indent of current (or selected) line(s)
		" <leader>e   - switch to normal editing mode

		let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'
		let g:VimTodoListsDatesEnabled    = 1

		function! VimTodoListsCustomMappings()
			nnoremap <buffer> <silent> <leader>O :VimTodoListsCreateNewItemAbove<cr>
			nnoremap <buffer> <silent> <O        :VimTodoListsCreateNewItemAbove<cr>
			nnoremap <buffer> <silent> <leader>o :VimTodoListsCreateNewItemBelow<cr>
			noremap  <buffer> <silent> <Space>   :VimTodoListsToggleItem<cr>
			noremap  <buffer> <silent> >>        :VimTodoListsIncreaseIndent<cr>
			noremap  <buffer> <silent> <tab>     :VimTodoListsIncreaseIndent<cr>
			noremap  <buffer> <silent> <<        :VimTodoListsDecreaseIndent<cr>
			set nosmartindent
		endfunction

	" Чтобы в больших вайлах свёртка кода не перерасчитывалась при введение
	" каждого символа
	" does't slow down
	Plug 'Konfekt/FastFold'


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ colorschemes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

	 let g:enable_italic_font = 1

	Plug 'kristijanhusak/vim-hybrid-material' " Металлический Джейкобс,           прозрачная *
	  let g:hybrid_transparent_background = 1
	Plug 'sainnhe/sonokai'                    " Самурайская тема,                 прозрачная *
	Plug 'sainnhe/gruvbox-material'           " Джейкобс, тёплая,               непрозрачная *
	Plug 'whatyouhide/vim-gotham'             " Очень тёмная,                   непрозрачная *
	Plug 'danilo-augusto/vim-afterglow'       " Тусклая,                        непрозрачная
	Plug 'AlessandroYorba/Alduin'             " Алдуиновская, зеленоватая,      непрозрачная *
	  let g:alduin_Shout_Dragon_Aspect   = 1
	Plug 'romainl/Apprentice'                 " Болотная,                       непрозрачная *
	Plug 'Badacadabra/vim-archery'            " Арч, чёрный фон, тёмно-синяя,   непрозрачная
	" Plug 'challenger-deep-theme/vim'          " Тёмная, но контраснтная,        непрозрачная *
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
		let g:oceanic_material_allow_bold      = 1
		let g:oceanic_material_allow_italic    = 1
		let g:oceanic_material_allow_underline = 1
	Plug 'rakr/vim-one'                       " Тёмная с фиолетовым, непрозрачная
	Plug 'joshdick/onedark.vim'               " То же, что one, но светлее и приятнее, непрозрачная
	Plug 'vim-scripts/rdark-terminal2.vim'    " Приятная, зелёно-голубая, прозрачная *
	Plug 'junegunn/seoul256.vim'              " Светлая, вебеленная, приятная, непрозрачная
	Plug 'AlessandroYorba/Sierra'             " Вишнявая, тёмная, приятная, непрозрачная *
		let g:sierra_Twilight = 1
		let g:sierra_Midnight = 0
		let g:sierra_Pitch    = 0
	Plug 'sonph/onehalf'                      "\
	Plug 'kyoz/purify'                        "\

	Plug 'dracula/vim'

call plug#end()
filetype on

" colorscheme rdark-terminal2
colorscheme sonokai








" ########################################################################## "
" ################################ MAPPINGS ################################ "
" ########################################################################## "

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ windows and tabs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

" Перемещение между окнами
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
nnoremap <leader>wh <C-w>H
nnoremap <leader>wj <C-w>J
nnoremap <leader>wk <C-w>K
nnoremap <leader>wl <C-w>L
nnoremap <leader>wq <C-w>x
nnoremap <leader>wt <C-w>T

" Перемещение между вкладками
nnoremap <C-h> gT
nnoremap <BS>  gT
nnoremap <C-l> gt

" Перемещение вкладок
nnoremap <leader>th :-tabmove<cr>
nnoremap <leader>tl :+tabmove<cr>
nnoremap <leader>tk :0tabmove<cr>
nnoremap <leader>tj :$tabmove<cr>

" Открытие новых вкладок/окон
nnoremap <C-t> :tabnew<cr>
nnoremap <C-f> :tabnew<space>
nnoremap \     :vnew<cr>
nnoremap \|    :new<cr>

" Закрытие окон
nnoremap gq :q!<cr>
nnoremap gQ :qa!<cr>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

" make
nnoremap <leader>b :wa<cr>:make!<cr>
nnoremap <leader>B :wa<cr>:make! re<cr>
nnoremap <leader>r :wa<cr>:make! run<cr>
nnoremap <leader>R :wa<cr>:make! rerun<cr>
nnoremap <leader>i :wa<cr>:make! run < input<cr>
nnoremap <leader>I :wa<cr>:make! run < input > output<cr>
nnoremap <leader>c :wa<cr>:make! fclean<cr>

nnoremap ) :cnext<cr>
nnoremap ( :cprev<cr>

" Переключение буферов
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>

" Операции с файлами
nnoremap <leader>fs :w<cr>
nnoremap <leader>fa :wa<cr>
nnoremap <leader>fr :e %<cr>
nnoremap <leader>fy :%y"<cr>
nnoremap <leader>fY :%y+<cr>

nnoremap <silent> <leader>fS :set expandtab<cr>
	\ :exe "1,$!retab -a t2s -t" . &tabstop<cr>
nnoremap <silent> <leader>fT :set noexpandtab<cr>
	\ :exe "1,$!retab -a s2t -t" . &tabstop<cr>
vnoremap <silent> <leader>fS :'<,'>!retab t2s<cr>
vnoremap <silent> <leader>fT :'<,'>!retab s2t<cr>
nnoremap <leader>W  :set wrap!<cr>

nnoremap <leader>dv :e $vimrc<cr>
nnoremap <leader>dV :tabnew $vimrc<cr>
nnoremap <leader>dR :source $vimrc<cr>
nnoremap <leader>dS :source .open.vim<cr>
nnoremap <leader>dD :!!<cr>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~ editing and moving ~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

noremap M J
noremap m dd
" nnoremap dd <nop>
nnoremap <leader>M m

inoremap <C-l> <delete>
inoremap <C-o> <esc>mqviwU`qa
inoremap <C-d> <esc>:call SwitchLanguage()<cr>a
nnoremap ]e :set iminsert=0<cr>
nnoremap ]r :set iminsert=1<cr>
inoremap JK <esc>S

noremap = $
noremap - ^

" чтобы ставить ударение
inoremap <C-v> <C-v>u0301







" ########################################################################## "
" ############################### FILETYPES ################################ "
" ########################################################################## "

let javaScript_fold            = 1
let g:python_recommended_style = 0
let g:rust_recommended_style   = 0

" Common
" does't slow down
au FileType c,cpp,java,js,php,python,glsl syntax match
	\ Function   /\(#.*\)\@<!\I\i\+\s*(\@=/
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

" C, CPP
au FileType cpp syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType c   syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType cpp syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType c   syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType c   syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
" au FileType c   nnoremap <silent> <buffer> <leader>v :!gcc -fsyntax-only %<cr>
" au FileType cpp nnoremap <silent> <buffer> <leader>v :!g++ -fsyntax-only %<cr>

" PYTHON
au FileType python setlocal foldmethod=indent tabstop=2 shiftwidth=2 expandtab
au FileType python nnoremap <silent> <buffer> <leader>r :wa<cr>:!python3 main.py<cr>
au FileType python nnoremap <silent> <buffer> <leader>i :wa<cr>:!python3 main.py < input<cr>

" BASH
au FileType sh setlocal foldmethod=indent tabstop=2 shiftwidth=2 expandtab

" VIM, HTML, XML, JSON, SH
au FileType vim        nnoremap <leader>e :exec getline('.')<cr>
au FileType vim        vnoremap <leader>e :<c-u>exec join(getline("'<", "'>"), "\n")<cr>
au FileType vim        setlocal foldmethod=indent tabstop=2 shiftwidth=2
au FileType sh         nnoremap <leader>e :!zsh -c shellescape(getline('.'))<cr>
au FileType sh         vnoremap <leader>e :<c-u>!zsh -c shellescape(join(getline("'<", "'>"), "\n"))<cr>
au FileType html       setlocal foldmethod=indent tabstop=2 shiftwidth=2
au FileType htmldjango setlocal foldmethod=indent tabstop=2 shiftwidth=2
au FileType xml        setlocal foldmethod=indent tabstop=2 shiftwidth=2
au FileType json       setlocal foldmethod=indent tabstop=2 shiftwidth=2
au FileType dart       setlocal tabstop=2 shiftwidth=2 expandtab

" RUST
au FileType rust nnoremap <silent> <buffer> <leader>r :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run<cr>
au FileType rust nnoremap <silent> <buffer> <leader>R :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run --release<cr>
au FileType rust nnoremap <silent> <buffer> <leader>i :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run < input<cr>
au FileType rust nnoremap <silent> <buffer> <leader>b :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build<cr>
au FileType rust nnoremap <silent> <buffer> <leader>B :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build --release<cr>
au FileType rust nnoremap <silent> <buffer> <leader>p :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo clean<cr>
" au FileType rust nnoremap <silent> <buffer> <leader>v :wa<cr>:!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo check<cr>
au FileType rust let g:AutoPairs = { "[" : "]", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''" }
au FileType rust compiler! cargo







" ########################################################################## "
" ############################## NORMAL MODE ############################### "
" ########################################################################## "

" !      # вызов фильтра
" @      # исполнить макрос
" #      # то же, что *, но в обратном порядке
" $      # REMAP, в конец строки
" %      # перенистись к парному символу
" ^      # REMAP, к началу строку (первый непробельный символ)
" &      # повторить замену (ОСВОИТЬ)
" *      # найти тот же идентификатор, что под курсором
" (      # US :cprev, предложение назад (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" )      # US :cnext, предложение вперяд (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" 0      # в начало строке (в самое-самое)
" -      # USE ^
" _      # REMAP
" =      # USE $
" +      # REMAP

" `  # go to the mark
" ~  # change case of character under cursor

" ]  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" [  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" }  # US <C-w>\>
" {  # US <C-w>\<
" \  # US :vnew<cr>
" |  # US :new<cr>

" ;       # повторный поиск в строке (f,F,t,T)
" '       # перейти к отметке
" "       # использовать регистр

" ,       # US <leader>
" <       #
" .       # повторить последнее редактирование
" >       #
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
" U       # US dd
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
" H       # US перейти в окно влево
" j       # вниз
" J       # US перейти на окно вниз
" k       # вверх
" K       # US перейти в окно вверх
" l       # вправо
" L       # US перейти в окно вправо
" z       # КОМАНДА С ПРОДОЛЖЕНИЕМ (см. отдельно)
" Z       # REMAP
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



" ################################ key-g ###############################

" g8     # print hex code of character under cursor
" gq     # US :q!
" gQ     # US :qa!
" gw     # REMAP
" gW     # REMAP
" ge     # US :Ag ""<left>
" gE     # REMAP
" gr     # US coc-references
" gR     # REMAP
" <N>gt  # next tab
" gt     # next tab
" gT     # prev tab
" gy     # US coc-type-definition
" gY     # REMAP
" gu     # REMAP
" gU     # REMAP
" gi     # US :vnew<cr>:FZF<cr>
" gI     # coc-implementation
" go     # :FZF<cr>
" gO     # REMAP
" gp     # REMAP
" gP     # REMAP
" ga     # REMAP
" gA     # REMAP
" gs     # REMAP
" gS     # REMAP
" gd     # US go to defenition
" gD     # coc show_documentation
" gf     # REMAP
" gF     # REMAP
" gg     # REMAP
" gG     # REMAP
" gh     # US :new<cr>:FZF<cr>
" gH     # REMAP
" gj     # REMAP
" gJ     # REMAP
" gk     # REMAP
" gK     # REMAP
" gl     # REMAP
" gL     # REMAP
" gz     # :tabnew<cr>:FZF<cr>
" gZ     # REMAP
" gx     # REMAP
" gX     # REMAP
" gc     # REMAP
" gC     # REMAP
" gv     # prev visual
" gV     # REMAP
" gb     # REMAP
" gB     # REMAP
" gn     # REMAP
" gN     # REMAP
" gm     # REMAP
" gM     # REMAP

" g[     # REMAP
" g{     # REMAP
" g]     # REMAP
" g}     # REMAP
" g\     # REMAP
" g|     # REMAP

" g;     # REMAP
" g:     # REMAP
" g'     # REMAP
" g"     # REMAP

" g,     # REMAP
" g<     # REMAP
" g.     # REMAP
" g>     # REMAP
" g/     # REMAP
" g?     # REMAP



" ################################ CTRL ################################

" <C-q>   # REMAP
" <C-w>   # КОМАНДА С ПРОДОЛЖЕНИЕМ (управление окнами)
" <C-e>   # переместить экран на строку вниз
" <C-r>   # redo
" <C-t>   # US :tabnew<cr>
" <C-y>   # строку вверх
" <C-u>   # полэкрана вверх
" <C-i>   # на следующую позицию
" <C-o>   # на предыдущую позицию
" <C-p>   # fzf (ОСВОИТЬ)
" <C-[>   # fzf (ОСВОИТЬ)
" <C-]>   # fzf (ОСВОИТЬ)
" <C-a>   # Увеличение числа на один
" <C-s>   # REMAP
" <C-d>   # на экран ниже
" <C-f>   # US :tabnew<SPACE>
" <C-g>   # REMAP, показать информацию о файле
" <C-h>   # US gT
" <C-j>   # переместить строку вниз
" <C-k>   # переместить строку вверх
" <C-l>   # US gt
" <C-;>   # US gt
" <C-'>   # US gt
" <C-z>   # остановить программу
" <C-x>   # US Color-Picker
" <C-c>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-v>   # визуальный блок
" <C-b>   # US :cprev
" <C-n>   # US :NERDTree
" <C-m>   # US :cnext

" <F1>    # REMAP
" <F2>    # REMAP
" <F3>    # REMAP
" <F4>    # REMAP
" <F5>    # REMAP
" <F6>    # REMAP
" <F7>    # REMAP
" <F8>    # REMAP
" <F9>    # REMAP
" <F10>   # REMAP
" <F11>   # REMAP
" <F12>   # REMAP



" ############################## LEADER ################################

" <leader>q REMAP
" <leader>Q REMAP
" <leader>w Управление окнами
"           h -> переместить текущее окно вправо
"           j -> переместить текущее окно вниз
"           k -> переместить текущее окно вверх
"           l -> переместить текущее окно влево
"           q -> поменять местами текущее и предыдущее окна
"           t -> переместить текущее окно в отдельную вкладку
"
" <leader>W US SwitchWrap
" <leader>e execute line under cursor
" <leader>E REMAP
" <leader>r run
" <leader>R rebuild and run
" <leader>t Управление вкладками
"           h -> :-tabmove
"           l -> :+tabmove
"           k -> :0tabmove
"           j -> :$tabmove
"
" <leader>T REMAP
" <leader>y REMAP
" <leader>Y REMAP
" <leader>u REMAP
" <leader>U REMAP
" <leader>i make run < input; rust: run < input, py: !python3 main.py < input
" <leader>I REMAP
" <leader>o py: JupyterRunFile
" <leader>O REMAP
" <leader>p make clean; rust: cargo clean
" <leader>P Toggle auto pairs
" <leader>a REMAP
" <leader>A REMAP
" <leader>s easy-motion
" <leader>S REMAP
" <leader>d Разнообразные операции
"           r -> :source $vimrc
"           h -> insert header
"           n -> norminette     (ft=c)
"           f -> c_formatter_42 (ft=c)
"           t -> spaces to tabs;
"           d -> @:
"           D -> :!!
"           v -> :e $vimrc
"           V -> :tabnew $vimrc
"
" <leader>D REMAP
" <leader>f File operations
"           s -> :w
"           a -> :wa
"           r -> :e %
"           y -> :%y"
"           Y -> :%y+
"           S -> tabs to spaces (retab)
"           T -> spaces to tabs (retab)
"
" <leader>F easy-motion
" <leader>g (GitGutter):
"           q :GitGutterQuickFix \| copen<cr>
"           u :GitGutterUndoHunk<cr>
"           s :GitGutterStageHunk<cr>
"           p :GitGutterPreviewHunk<cr>
"           f :GitGutterFold<cr>
"           h :GitGutterLineHighlightsToggle<cr>
"
" <leader>G REMAP
" <leader>h REMAP
" <leader>H REMAP
" <leader>j REMAP
" <leader>J REMAP
" <leader>k REMAP
" <leader>K REMAP
" <leader>l REMAP
" <leader>L REMAP
" <leader>z Goyo
" <leader>Z double Goyo (Goyo refresh)
" <leader>x py: Ju run cell
" <leader>X REMAP
" <leader>c
"           c       -> add comment
"           s       -> add pretty commend
"           <space> -> toggle commend
"           h       -> c2h (ft=c|cpp)
"           $/=     -> comment line started from the current position
"           A       -> add comment on end of line
"           a       -> change comment style // -> /* */
"
" <leader>C JupyterConnect (ft=py)
" <leader>v (VimSpector)
" 					v -> launch
" 					p -> pause
" 					s -> stop
" 					r -> restart
" 					t -> toggle breakpoint
" 					T -> toggle conditional breakpoint
" 					c -> run to cursor
" 					o -> step over
" 					i -> step into
" 					O -> step out of current function
" 					u -> move up a frame in the current call stack
" 					d -> move down a frame
" 					e -> evaluate expression under cursor into popup
" <leader>V REMAP
" <leader>b build
" <leader>B rebuild
" <leader>n REMAP
" <leader>N REMAP
" <leader>m REMAP
" <leader>M REMAP





" ######################################################################
" ############################ INSERT MODE #############################
" ######################################################################

" <C-q>   # h1
" <C-w>   # удалить слово перед курсором
" <C-e>   # REMAP
" <C-r>   # вставить из регистра
" <C-t>   # сделать таб в начале строки (ОСВОИТЬ)
" <C-y>   # emmet
" <C-u>   # удалить строку
" <C-i>   # сделать таб (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-o>   # US преобразовать слово к верхнему регистру
" <C-p>   # REMAP
" <C-[>   # REMAP
" <C-]>   # REMAP
" <C-a>   # REMAP
" <C-s>   # REMAP
" <C-d>   # US изменить язык
" <C-f>   # REMAP
" <C-g>   # REMAP
" <C-h>   # удалить символ перед курсором (backspace)
" <C-j>   # US раскрыть сниппет
" <C-k>   # вставить спецсимвол/дополнение
" <C-l>   # US удалить символ после курсора (del)
" <C-z>   # REMAP
" <C-x>   # US color-picker
" <C-c>   # REMAP
" <C-v>   # REMAP поставить ударение
" <C-b>   # REMAP
" <C-n>   # REMAP, вимовское автодополнение
" <C-m>   # REMAP







" ######################################################################
" ################################ DOCS ################################
" ######################################################################

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
" \r	<cr>
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
" \i  identifier characters   'isident'
" \I  like \i, excluding digits
" \k  keyword characters      'iskeyword'
" \K  like \k, excluding digits
" \p  printable characters    'isprint'
" \P  like \p, excluding digits
" \f  file name characters    'isfname'
" \F  like \f, excluding digits







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


" ######################################################################
" ############################### NOTES ################################
" ######################################################################

" Сохранение содержимого в новый файл: save filename







" ######################################################################
" ############################### END ##################################
" ######################################################################
