Sunday.vim
==========

Switch from currently word to definition list using [Vim](http://vim.org/)

Like `<C-a>`, `<C-x>` (in|de)crease currently number by the default Vim

You can customize list of the word of do (in|de)crease


Installation
------------

### Using [NeoBundle.vim](https://github.com/Shougo/neobundle.vim)

```viml
NeoBundle 'nishigori/vim-sunday'
```

### Using [Vundle](https://github.com/gmarik/vundle)

```viml
Bundle 'nishigori/vim-sunday'
```

### Getting manual

```sh
wget -O vim-sunday-master.zip https://github.com/nishigori/vim-sunday/archive/master.zip
unzip vim-sunday-master.zip
mv vim-sunday-master/plugin/sunday.vim {YOUR VIMRUNTIME}/plugin/
```


Usage
-----

sunday.vim is supporting specifed pairs (variable is `g:sunday_pairs`)

**NOTE:** `g:sunday_pairs` will no longer be in the future.

### Default pairs list

```
  yes  <-> no
  on   <-> off
  true <-> false
  weekday (sunday <-> monday <-> wednesday <- .. -> saturday <-> sunday)
  weekday-shorten (sun <-> mon <-> .. sat <-> sun)
  month (january <-> february <-> .. <-> december <-> january)
  month-shorten (jan <-> feb .. dec <-> jan)
  public <-> protected <-> private
```

### Example

```viml
" Your .vimrc
let g:sunday_pairs = [
  \   ['extends', 'implements'],
  \   ['require', 'require_once', 'include', 'include_once'],
  \   ['pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
  \ ]

"  =>
"
"extends <-> implements
"require <-> require_once <-> include <-> include_once <-> require
"pick <-> reword <-> edit <-> squash <-> fixup <-> exec
```


TODO
----

* custom mapping (ex. nnoremap <Leader>a (sunday#increase))
* support filetype pairs list.


Author & Contributors
---------------------

* Takuya Nishigori <nishigori.tak@gmail.com>
* [Contributors](https://github.com/nishigori/vim-sunday/graphs/contributors)


Inspired by
-----------

* [monday.vim][] created by Stefan Karlsson <stefan.74@comhem.se>
* [monday-custom][] created by Taku Omi <http://nanasi.jp/>

[monday.vim]:       http://www.vim.org/scripts/script.php?script_id=1046
[monday-custom]:    http://nanasi.jp/articles/vim/monday_vim.html


LICENSE
-------

Sunday.vim is released under the MIT License. See the bundled LICENSE file for details.
