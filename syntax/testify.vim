if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'testify'

syn region TestifyInfo start=/^\s*\*.*/ end=/^\ze\s*[√✗\*].*/
hi def link TestifyInfo Normal

syn region TestifySuccess start=/^\s*√.*/ end=/^\ze\s*[√✗\*].*/
hi def link TestifySuccess Special

syn region TestifyFailure start=/^\s*✗.*/ end=/^\ze\(^$\)\|\(\s*[√✗\*].*\)/
hi def link TestifyFailure Error
