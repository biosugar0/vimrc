syntax on
set redrawtime=3000 " 指定したミリ秒以上の時間がかかるとき、それ以上のマッチはハイライトされない。
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
filetype plugin indent on

let g:terminal_ansi_colors = [
    \ '#666666',
    \ '#f43753',
    \ '#c9d05c',
    \ '#ffc24b',
    \ '#b3deef',
    \ '#d3b987',
    \ '#73cef4',
    \ '#eeeeee',
    \ '#666666',
    \ '#f43753',
    \ '#c9d05c',
    \ '#ffc24b',
    \ '#b3deef',
    \ '#d3b987',
    \ '#73cef4',
    \ '#ffffff'
    \ ]

let g:polyglot_disabled = ['csv' , 'ftdetect']
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_hightlight_operators = 1
let g:go_hightlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_hightlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_hightlight_methods = 1
let g:go_hightlight_structs = 1
let g:go_hightlight_interfaces = 1
