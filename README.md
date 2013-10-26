Sunday.vim
==========

Switch from currently word using [Vim](http://vim.org/)

The behavior is like `<C-a>`, `<C-x>` (in|de)crease currently number by the default Vim's key-map

Inspired by [monday.vim](http://www.vim.org/scripts/script.php?script_id=1046)

It's customizable list of the word of do (in|de)crease in your .vimrc


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

### Example your vimrc

```viml
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


Author(s)
---------

* Takuya Nishigori <nishigori.tak@gmail.com>
* [Contributors](https://github.com/nishigori/vim-sunday/graphs/contributors)


LICENSE
-------

Sunday.vim is released under the MIT License. See the bundled LICENSE file for details.
