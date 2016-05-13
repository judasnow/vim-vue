" Vim syntax file
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote

if exists("b:current_syntax")
  finish
endif

if !exists("s:syntaxes")
  " Search available syntax files.
  function s:search_syntaxes(...)
    let syntaxes = {}
    let names = a:000
    for name in names
      let syntaxes[name] = 0
    endfor

    for path in split(&runtimepath, ',')
      if isdirectory(path . '/syntax')
        for name in names
          let syntaxes[name] = syntaxes[name] || filereadable(path . '/syntax/' . name . '.vim')
        endfor
      endif
    endfor
    return syntaxes
  endfunction

  let s:syntaxes = s:search_syntaxes('less')
endif


syntax include @HTML syntax/html.vim
unlet b:current_syntax
syntax region template keepend start=/^<template>/ end=/^<\/template>/ contains=@HTML fold

syntax include @JS syntax/javascript.vim
unlet b:current_syntax
syntax region script keepend start=/<script>/ end=\<^\/script>/ contains=@JS fold

if s:syntaxes.less
  syntax include @less syntax/less.vim
  unlet b:current_syntax
  syntax region less keepend matchgroup=PreProc start=/<style\%( \+scoped\)\? lang="less"\%( \+scoped\)\?>/ end=/^<\/style>/ contains=@less fold
endif

let b:current_syntax = "vue"
