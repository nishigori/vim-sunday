"=============================================================================
" FILE: sunday.vim
" AUTHOR: Takuya Nishigori <nishigori.tak@gmail.com>
" Last Modified: 2011-12-26
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Version: 0.1, for Vim 7.2~
"
"=============================================================================

" Load Once {{{
if v:version < 702
  echoerr 'sunday.vim does not supported version Vim (' . v:version . ').'
  finish
elseif exists('g:loaded_sunday')
  finish
endif
" }}}

let s:save_cpo = &cpo
set cpo&vim

let s:words = ''
" Key mapping {{{
nnoremap <silent> <Plug>(sunday-increase) :<C-u>call sunday#IncDec('inc')<CR>
nnoremap <silent> <Plug>(sunday-decrease) :<C-u>call sunday#IncDec('dec')<CR>
" }}}
" Default key mapping "{{{
"FIXME: static <C-a>, <C-x> map
"if !exists('g:sunday_disabled_default_mapping')
  "nnoremap <silent> <C-a> <Plug>(sunday-increase)
  "nnoremap <silent> <C-x> <Plug>(sunday-decrease)
"endif
"}}}

function! sunday#addPairs(lists)  "{{{
  for list in a:lists
    let length = len(list)
    let index = 1

    for first_word in list
      let next_word = index != length ? list[index] : list[0]
      call s:AddPair(first_word, next_word)
      let index += 1
    endfor
  endfor
endfunction "}}}
function s:AddPair(word1, word2) "{{{
  let w10 = tolower(a:word1)
  let w11 = toupper(matchstr(w10, '.')) . matchstr(w10, '.*', 1)
  let w12 = toupper(w10)

  let w20 = tolower(a:word2)
  let w21 = toupper(matchstr(w20, '.')) . matchstr(w20, '.*', 1)
  let w22 = toupper(w20)

  let s:words = s:words . w10 . ':' . w20 . ','
  let s:words = s:words . w11 . ':' . w21 . ','
  let s:words = s:words . w12 . ':' . w22 . ','
endfunction "}}}
function s:MakeMapping(inc_or_dec) "{{{
  if a:inc_or_dec == 'inc' || a:inc_or_dec == 'both'
    nnoremap <silent> <c-a> :<c-u>call <SID>IncDec('inc')<CR>
  endif
  if a:inc_or_dec == 'dec' || a:inc_or_dec == 'both'
    nnoremap <silent> <c-x> :<c-u>call <SID>IncDec('dec')<CR>
  endif
endfunction "}}}
function s:IncDec(inc_or_dec) "{{{
  let N = (v:count < 1) ? 1 : v:count
  let i = 0
  if a:inc_or_dec == 'inc'
    while i < N
      let w = expand('<cword>')
      if s:words =~# '\<' . w . ':'
        let n = match(s:words, w . ':\i\+\C')
        let n = match(s:words, ':', n)
        let a = matchstr(s:words, '\i\+', n)
        execute "normal ciw" . a
      else
        nunmap <c-a>
        execute "normal \<c-a>"
        call <SID>MakeMapping('inc')
      endif
      let i = i + 1
    endwhile
  else "inc_or_dec == 'dec'
    while i < N
      let w = expand('<cword>')

      if s:words =~# ':' . w . '\>'
        let n = match(s:words, '\i\+\C:' . w)
        let a = matchstr(s:words, '\i\+', n)
        execute "normal ciw" . a
      else
        nunmap <c-x>
        execute "normal \<c-x>"
        call <SID>MakeMapping('dec')
      endif
      let i = i + 1

    endwhile
  endif
endfunction " }}}
" FUTURE: Someone wan't to use by default?"{{{
let s:default_pairs = [
  \   ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'],
  \   ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'],
  \   ['jan', 'feb', 'mar', 'apr', 'may', 'june', 'july', 'aug', 'sep', 'oct', 'nov', 'dec'],
  \   ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
  \   ['true', 'false'],
  \   ['yes', 'no'],
  \   ['on', 'off'],
  \   ['private', 'protected', 'public'],
  \ ] "}}}

call <SID>MakeMapping('both')
call sunday#addPairs(s:default_pairs)
if exists('g:sunday_pairs')
  call sunday#addPairs(g:sunday_pairs)
endif

let g:loaded_sunday = 1
let &cpo = s:save_cpo
unlet s:save_cpo


" vim:set fdm=marker ts=2 sw=2 sts=0:
