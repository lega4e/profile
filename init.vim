"''''''''''''''''''''''''''''''''''''''''''''''''''''''''

" переключение языков
function! Switch()
	if &iminsert == 0
		set iminsert=1
	else
		set iminsert=0
	endif
endfunction

let g:mapleader=','

set autoindent 
set autoread	" автоматически загружать внешние изменения файла
" set list " отображать симоволы табуляции
set nocompatible
set nohlsearch
set noswapfile
set number	    " нумерование строк
set shiftwidth=4
" set smartindent " умные отступы
" set smarttab
set splitright
set tabstop=4
set splitbelow

" мышка
set mousehide
set mouse=a
set novisualbell
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showtabline=1" set foldcolumn=1

" раскладка
set keymap=russian-dictor
set iminsert=0
set imsearch=0
set foldmethod=syntax





"'''''''''''''''''''''''' PLUGINS ''''''''''''''''''''''''''
call plug#begin('~/.config/nvim/autoload/plugged')


Plug 'vim-airline/vim-airline'
Plug 'ycm-core/YouCompleteMe' " автодополнение
	" let g:ycm_clangd_binary_path = "/usr/bin/clangd"
	let g:ycm_global_ycm_extra_conf           = '~/.ycm_extra_conf.py'
	let g:ycm_max_num_candidates              = 50
	let g:ycm_key_list_select_completion      = [ '<tab>', '<down>', '<c-k>' ]
	let g:ycm_key_list_previous_completion    = [ '<up>' ]
	let g:ycm_auto_trigger                    = 1
	let g:ycm_min_num_of_chars_for_completion = 3
	let g:ycm_show_diagnostics_ui             = 0
	let g:ycm_enable_diagnostic_signs         = 0
	let g:ycm_filter_diagnostics              = { "cpp": { "level": "warning" } }
	let g:ycm_key_list_stop_completion        = ['']
	let g:ycm_key_invoke_completion           = '<c-space>'
	set completeopt-=preview
	nmap gd :YcmCompleter GoTo<cr>
	nmap gs :YcmCompleter GoToSymbol<space>

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" if has("patch-8.1.1564")
	  " set signcolumn=number
	" else
	  " set signcolumn=yes
	" endif

	" function! s:check_back_space() abort
	  " let col = col('.') - 1
	  " return !col || getline('.')[col - 1]  =~ '\s'
	" endfunction

	" inoremap <silent><expr> <Tab>
		  " \ pumvisible() ? "\<C-n>" :
		  " \ <SID>check_back_space() ? "\<Tab>" :
		  " \ coc#refresh()

Plug 'scrooloose/nerdcommenter' " комментирование
	let g:NERDSpaceDelims = 2

Plug 'SirVer/ultisnips' " сниппеты
	let g:UltiSnipsExpandTrigger="<c-j>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"
	let g:UltiSnipsEditSplit="vertical"

Plug 'https://github.com/vim-scripts/highlight_current_line.vim'

Plug 'scrooloose/nerdtree' " просмотр файловой системы 
	map <C-n> :NERDTreeToggle<CR>

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

Plug 'kien/ctrlp.vim'
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
	nmap gi :vnew<CR>:FZF<CR>
	nmap gz :tabnew<CR>:FZF<CR>
	nmap <C-f> :FZF<CR>

Plug 'KabbAmine/vCoolor.vim' " color-picker <Alt+c>
	let g:vcoolor_map = '<C-x>'

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

packadd! vimspector
	" let g:vimspector_enable_mappings = 'HUMAN'
	map <F22> :call vimspector#StepInto()<CR>

" colorschemes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'sainnhe/sonokai'
Plug 'tmhedberg/simpylfold'

Plug 'ryanoasis/vim-devicons'
	set encoding=UTF-8
	set guifont=DroidSansMono\ Nerd\ Font\ 10
	let g:airline_powerline_fonts = 1

Plug 'jupyter-vim/jupyter-vim'
	let g:python3_host_prog = '/usr/bin/python3'
	let g:jupyter_mapkeys   = 0
	" Run current file
	au FileType python map <silent> <buffer> <leader>r :JupyterRunFile<CR>
	" au FileType python map <silent> <buffer> <leader>I :PythonImportThisFile<CR>

	" Change to directory of current file
	" au FileType python map <silent> <buffer> <leader>d :JupyterCd %:p:h<CR>

	" Send a selection of lines
	au FileType python nmap <silent> <buffer> <leader>x :JupyterSendCell<CR>
	" au FileType python nmap <silent> <buffer> <leader>E :JupyterSendRange<CR>
	au FileType python nmap <silent> <buffer> <leader>e V<leader>e<esc>
	au FileType python vmap <silent> <buffer> <leader>e <Plug>JupyterRunVisual

	nnoremap <buffer> <silent> <leader>U :JupyterUpdateShell<CR>

	" Debugging maps
	nnoremap <buffer> <silent> <leader>b :PythonSetBreak<CR>

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'jiangmiao/auto-pairs'
	let g:AutoPairs = { "[" : "]", "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''" }
" Plug 'rust-lang/rust.vim'
" Plug 'cacharle/c_formatter_42.vim'
	au FileType c nmap <silent> <buffer> <leader>dn :Norminette<CR>
	au FileType c nmap <silent> <buffer> <leader>df :CFormatter42<CR>

Plug 'matze/vim-move'
	nmap <C-j> <Plug>MoveLineDown
	nmap <C-k> <Plug>MoveLineUp
	vmap <C-j> <Plug>MoveBlockDown
	vmap <C-k> <Plug>MoveBlockUp

" Plug 'vim-utils/vim-man'
" Plug 'gauteh/vim-cppman'
	auto FileType cpp nnoremap <leader>dc :Cppman<SPACE>
	auto FileType c   nnoremap <leader>dc :Cppman<SPACE>

" Plug 'octol/vim-cpp-enhanced-highlight'
	" let g:cpp_class_scope_highlight                  = 1
	" let g:cpp_member_variable_highlight              = 1
	" let g:cpp_class_decl_highlight                   = 1
	" let g:cpp_posix_standard                         = 1
	" let g:cpp_experimental_simple_template_highlight = 1
	" let g:cpp_experimental_template_highlight        = 1
	" let g:cpp_concepts_highlight                     = 1
Plug 'bfrg/vim-cpp-modern'

call plug#end()
filetype on
colorscheme sonokai " цветовая схема

let g:SimpylFold_docstring_preview = 1 " ???







"''''''''''''''''''''''' MAPPINGS ''''''''''''''''''''''''''

" NORMAL AND VISUAL MODE MAPPINGS
" окна
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l
nnoremap M J
vnoremap M J
nnoremap <C-q> :q!<CR>
nnoremap \| :vnew<CR>

" перемещения
map = $
map - ^

nnoremap ]e :set iminsert=0<CR>
nnoremap ]r :set iminsert=1<CR>

" ошибки компилятора
nnoremap <C-h> :cprevious<CR>
nnoremap <C-l> :cnext<CR>

" переключение буферов
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>


" операции со всем файлом
nnoremap <C-s> :source .open.vim<cr>
nnoremap <leader>dh :%!mdtohtml --html4tags <CR>
nnoremap <leader>dr :e %<CR>
nnoremap <leader>dy :%y+<CR>
nnoremap <leader>dm :Man<SPACE>
nnoremap <silent> <leader>ds :set expandtab<CR>:exe "1,$!retab -a t2s -t" . &tabstop<CR>
nnoremap <silent> <leader>dt :set noexpandtab<CR>:exe "1,$!retab -a s2t -t" . &tabstop<CR>
vnoremap <silent> <leader>ds :'<,'>!retab t2s<CR>
vnoremap <silent> <leader>dt :'<,'>!retab s2t<CR>

" make
nnoremap <F2> 1gt:wa<CR>:make build<CR>
nnoremap <F3> 1gt:wa<CR>:make run<CR>
nnoremap <F4> 1gt:wa<CR>:make re<CR>
nnoremap <F5> 1gt:wa<CR>:make test<CR>

nnoremap <leader>r :make run<CR>
nnoremap <leader>R :make re<CR>
nnoremap <leader>i :make run < input<CR>
nnoremap <leader>b :make<CR>
nnoremap <leader>p :make clean<CR>




" INSERT MODE MAPPINGS

inoremap <C-l> <delete>
inoremap <C-o> <esc>gUiwe
inoremap <C-d> <esc>:call Switch()<CR>a

" чтобы ставить ударения
inoremap <C-v> <C-v>u0301





"''''''''''''''''''' FILE TYPES COMS '''''''''''''''''''

let javaScript_fold            = 1
let g:python_recommended_style = 0
let g:rust_recommended_style   = 0

" CPP, C
au FileType cpp syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType cpp syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType cpp syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType cpp nnoremap <silent> <buffer> <leader>v :!g++ -fsyntax-only %
" au FileType cpp syntax keyword Type template typename

au FileType c   syntax keyword Type byte ubyte ushort uint ulong llong ull ullong ldouble id_t
au FileType c   syntax keyword Type byte_p ubyte_p short_p ushort_p int_p uint_p
au FileType c   syntax keyword Type llong_p ullong_p float_p double_p ldouble_p
au FileType c   nnoremap <silent> <buffer> <leader>v :!gcc -fsyntax-only %


" PYTHON
au FileType python setlocal foldmethod=indent
au FileType python nnoremap <silent> <buffer> <leader>r :!python3 main.py<CR>
au FileType python nnoremap <silent> <buffer> <leader>i :!python3 main.py < input<CR>


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
au FileType rust nnoremap <silent> <buffer> <leader>r :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run<CR>
au FileType rust nnoremap <silent> <buffer> <leader>R :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run --release<CR>
au FileType rust nnoremap <silent> <buffer> <leader>i :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo run < input<CR>
au FileType rust nnoremap <silent> <buffer> <leader>b :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build<CR>
au FileType rust nnoremap <silent> <buffer> <leader>B :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo build --release<CR>
au FileType rust nnoremap <silent> <buffer> <leader>p :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo clean<CR>
au FileType rust nnoremap <silent> <buffer> <leader>v :!RUSTFLAGS="$RUSTFLAGS -A dead_code" cargo check<CR>
au FileType rust let g:AutoPairs = { "[" : "]", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''" }
au FileType rust compiler! cargo







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
" 		, - 		повторить поииск в другую сторону
" 		<C-w> <     уменьшить ширину окна
" 		<C-w> >     увеличить ширину окна
" 		<C-w> -     уменьшить высоту окна
" 		<C-w> +     увеличить высоту окна
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
" -      # k^ (ОПРОБОВАТЬ)
" _      # ^
" =      # МОЖНО ПЕРЕНАЗНАЧИТЬ
" +      # j^ (ОПРОБОВАТЬ)

" ]  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" [  # КОМАНДА С ПРОДОЛЖЕНИЕМ
" }  # параграф назад
" {  # параграф вперёд
" \  # старый leader (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" |  # ??? (МОЖНО ПЕРЕНЗНАЧИТЬ)
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
" U       # ???
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

" <C-q>   # US :q!<CR>
" <C-w>   # КОМАНДА С ПРОДОЛЖЕНИЕМ (управление окнами)
" <C-e>   # переместиться на строку вниз
" <C-r>   # redo
" <C-t>   # ??? (marks?)
" <C-y>   # строку вверх
" <C-u>   # полэкрана вверх
" <C-i>   # на следующую позицию
" <C-o>   # на предыдущую позицию
" <C-p>   # fzf (ОСВОИТЬ)
" <C-a>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-s>   # US :source .open.vim<CR>
" <C-d>   # на экран ниже
" <C-f>   # US fzf open file in current window
" <C-g>   # показать информацию о файле (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-h>   # US :cprevious
" <C-j>   # переместить строку вниз
" <C-k>   # переместить строку вверх
" <C-l>   # US :cnext
" <C-z>   # остановить программу
" <C-x>   # US Color-Picker
" <C-c>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-v>   # визуальный блок
" <C-b>   # экран вверх (МОЖНО ПЕРЕНАЗНАЧИТЬ)
" <C-n>   # US :NERDTree
" <C-m>   # ??? (МОЖНО ПЕРЕНАЗНАЧИТЬ)

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
" <leader>w US easy-motion к началу слова после
" <leader>W US easy-motion к началу СЛОВА после
" <leader>e US easy-motion к конца слова после
" <leader>E US easy-motion к конца СЛОВА после
" <leader>r US make run; rust: run, py: !python3 main.py
" <leader>R US make re;  rust: run --release
" <leader>t ???
" <leader>T ???
" <leader>y ???
" <leader>Y ???
" <leader>u ???
" <leader>U ???
" <leader>i US make run < input; rust: run < input, py: !python3 main.py < input
" <leader>I ???
" <leader>o ???
" <leader>O ???
" <leader>p US make clean; rust: cargo clean
" <leader>P ???
" <leader>a ???
" <leader>A ???
" <leader>s US easy-motion
" <leader>S ???
" <leader>d r -> reload; y -> yank; h -> md2html; c: n -> norminette; c: f -> fmt42;
"           m -> Man; c, cpp: c -> Cppman; s -> tab to spaces; t -> spaces to tabs;
" <leader>D ???
" <leader>f US easy-motion
" <leader>F US easy-motion
" <leader>g ???
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
" <leader>x ???
" <leader>X ???
" <leader>c US comment plugin
" <leader>C ???
" <leader>v US rust: check
" <leader>V ???
" <leader>b US make; rust: build
" <leader>B US rust: build --release
" <leader>n ???
" <leader>N ???
" <leader>m ???
" <leader>M ???

" Двойные команды для d


" Двойные команды для c


" Двойные команды для y


" Двойные команды для g


" Двойные команды для z


" Двойные команды для m





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







" END
