function! go#config#FoldEnable(...) abort
  if a:0 > 0
    return index(go#config#FoldEnable(), a:1) > -1
  endif
  return get(g:, 'go_fold_enable', ['block', 'import', 'varconst', 'package_comment'])
endfunction

function! go#config#HighlightGenerateTags() abort
  return get(g:, 'go_highlight_generate_tags', 0)
endfunction

function! go#config#HighlightArrayWhitespaceError() abort
  return get(g:, 'go_highlight_array_whitespace_error', 0)
endfunction

function! go#config#HighlightChanWhitespaceError() abort
  return get(g:, 'go_highlight_chan_whitespace_error', 0)
endfunction

function! go#config#HighlightExtraTypes() abort
  return get(g:, 'go_highlight_extra_types', 0)
endfunction

function! go#config#HighlightSpaceTabError() abort
  return get(g:, 'go_highlight_space_tab_error', 0)
endfunction

function! go#config#HighlightTrailingWhitespaceError() abort
  return get(g:, 'go_highlight_trailing_whitespace_error', 0)
endfunction

function! go#config#HighlightOperators() abort
  return get(g:, 'go_highlight_operators', 0)
endfunction

function! go#config#HighlightFunctions() abort
  return get(g:, 'go_highlight_functions', 0)
endfunction

function! go#config#HighlightFunctionParameters() abort
  " fallback to highlight_function_arguments for backwards compatibility
  return get(g:, 'go_highlight_function_parameters', get(g:, 'go_highlight_function_arguments', 0))
endfunction

function! go#config#HighlightFunctionCalls() abort
  return get(g:, 'go_highlight_function_calls', 0)
endfunction

function! go#config#HighlightFields() abort
  return get(g:, 'go_highlight_fields', 0)
endfunction

function! go#config#HighlightTypes() abort
  return get(g:, 'go_highlight_types', 0)
endfunction

function! go#config#HighlightBuildConstraints() abort
  return get(g:, 'go_highlight_build_constraints', 0)
endfunction

function! go#config#HighlightStringSpellcheck() abort
  return get(g:, 'go_highlight_string_spellcheck', 1)
endfunction

function! go#config#HighlightFormatStrings() abort
  return get(g:, 'go_highlight_format_strings', 1)
endfunction


function! go#config#HighlightVariableAssignments() abort
  return get(g:, 'go_highlight_variable_assignments', 0)
endfunction

function! go#config#HighlightVariableDeclarations() abort
  return get(g:, 'go_highlight_variable_declarations', 0)
endfunction

function! go#config#HighlightDiagnosticErrors() abort
  return get(g:, 'go_highlight_diagnostic_errors', 1)
endfunction

function! go#config#HighlightDiagnosticWarnings() abort
  return get(g:, 'go_highlight_diagnostic_warnings', 1)
endfunction

function! go#config#HighlightDebug() abort
  return get(g:, 'go_highlight_debug', 1)
endfunction
