# Shell Tools and Scripting

## Solutions

### Exercise 1

Completed `vimtutor`.

```
$ vimtutor
```

### Exercise 2

Downloaded the Missing Semester's [basic vimrc](https://missing.csail.mit.edu/2020/files/vimrc).

```
$ vim .vimrc
```

### Exercise 3

[ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) installed and configured to be mapped to Ctrl-P.

```
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
```

### Exercise 4

Edited demo python script using vim.

```
def fizz_buzz(limit):
    for i in range(limit):
        if i % 3 == 0:
            print('fizz')
        if i % 5 == 0:
            print('fizz')
        if i % 3 and i % 5:
            print(i)

def main():
    fizz_buzz(10)
```

### Exercise 5

I'll certainly use vim for lone text file editing for the next month.

### Exercise 6

I added Vimium to Google Chrome and will try VSCodeVim too.

### Exercise 7

Installed [nerdtree](https://github.com/preservim/nerdtree) 

```
~/test$ cd ~/.vim/pack/vendor/start
~/.vim/pack/vendor/start$ git clone https://github.com/preservim/nerdtree
```

Added shortcuts to `~/.vimrc`:

```
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
```

### Exercise 8

I expanded the regexes given as examples in the "Macros" section.

```
%s/<people>/[/g
%s/<\/people>/]/g
%s/<person>/{/g
%s/<\/person>/},/g
%s/<name>\(.*\)<\/name>/"name": "\1",/g
%s/<email>\(.*\)<\/email>/"email": "\1"/g
```

I then typed `q0` followed by entering these commands, then `q@0`.