"=============================================================================
" FILE: sunday.vim
" AUTHOR: Takuya Nishigori <nishigori.tak@gmail.com>
" Last Modified: 10 Oct 2011
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
" Version: 0.1, for Vim 7.0~
"
" Inspired1: monday
"   Name: monday.vim
"   CreatedBy:   Stefan Karlsson <stefan.74@comhem.se>
"   Url:  http://www.vim.org/scripts/script.php?script_id=1046
"   Purpose:  To make <ctrl-a> and <ctrl-x> operate on the names of weekdays
"             and months.
" Inspired2: monday_custom
"   CreateBy: Taku Omi <http://nanasi.jp/>
"   Url: http://nanasi.jp/articles/vim/monday_vim.html
"=============================================================================

" Load Once {{{
if exists('g:loaded_sunday') && g:loaded_sunday
  finish
endif
let g:loaded_sunday = 1
" }}}

" Key mapping {{{
nnoremap <Plug>(sunday-increase) :<C-u>call sunday#IncDec('inc')<CR>
nnoremap <Plug>(sunday-decrease) :<C-u>call sunday#IncDec('dec')<CR>
"inoremap <Plug>(sunday-increase) :<C-u>call sunday#IncDec('inc')<CR>
"inoremap <Plug>(sunday-decrease) :<C-u>call sunday#IncDec('dec')<CR>
" }}}

" Default key mapping "{{{
"FIXME: とりあえず今は<C-a>と<C-x>固定
"if !exists('g:sunday_disabled_default_mapping')
  "nnoremap <silent> <C-a> <Plug>(sunday-increase)
  "nnoremap <silent> <C-x> <Plug>(sunday-decrease)
"endif
"}}}

" FUTURE: enabled filetype sunday list.
" Filetype lists
"if exists('g:sunday_filetype_lists')
  "let g:sunday_filetype_lists = {}
"endif

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
" s:words = 'true:false,True:False,TRUE:FALSE,'
" w11やw21で先頭を大文字にしてる
" w12,w22で全大文字

let s:words = ''

" Mappingをつくってるだけ
function s:MakeMapping(inc_or_dec) "{{{
  if a:inc_or_dec == 'inc' || a:inc_or_dec == 'both'
    nnoremap <silent> <c-a> :<c-u>call <SID>IncDec('inc')<cr>
  endif
  if a:inc_or_dec == 'dec' || a:inc_or_dec == 'both'
    nnoremap <silent> <c-x> :<c-u>call <SID>IncDec('dec')<cr>
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


call <SID>MakeMapping('both')

" FUTURE: Someone wan't to use by default?
let s:default_pairs = [
  \   ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'],
  \   ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'],
  \   ['jan', 'feb', 'mar', 'apr', 'may', 'june', 'july', 'aug', 'sep', 'oct', 'nov', 'dec'],
  \   ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
  \   ['true', 'false'],
  \   ['yes', 'no'],
  \   ['on', 'off'],
  \   ['public', 'protected', 'private'],
  \ ]
call sunday#addPairs(s:default_pairs)

if exists('g:sunday_pairs')
  call sunday#addPairs(g:sunday_pairs)
endif

" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
