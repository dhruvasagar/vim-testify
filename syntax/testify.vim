if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'testify'

syn region TestifyHeader  start=/^\s*-/ end=/.*:$/
hi def link TestifyHeader Normal

syn region TestifySuccess start=/^\s*√.*/ end=/^\ze\s*[√✗-].*/
hi def link TestifySuccess Special

syn region TestifyFailure start=/^\s*✗.*/ end=/^\ze\s*[√✗-].*/
hi def link TestifyFailure Error
