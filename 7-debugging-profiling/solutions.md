# Debugging and Profiling

## Solutions 

### Debugging

#### Exercise 1

```
journalctl --since "1d ago" | grep -E sudo.*USER=root
```

#### Exercise 2

Done the `pdb-tutorial`.

#### Exercise 3

```
$ shellcheck test.sh

In test.sh line 3:
for f in $(ls *.m3u)
         ^---------^ SC2045 (error): Iterating over ls output is fragile. Use globs.
              ^-- SC2035 (info): Use ./*glob* or -- *glob* so names with dashes won't become options.


In test.sh line 5:
  grep -qi hq.*mp3 $f \
           ^-----^ SC2062 (warning): Quote the grep pattern so the shell won't interpret it.
                   ^-- SC2086 (info): Double quote to prevent globbing and word splitting.

Did you mean: 
  grep -qi hq.*mp3 "$f" \


In test.sh line 6:
    && echo -e 'Playlist $f contains a HQ file in mp3 format'
            ^-- SC3037 (warning): In POSIX sh, echo flags are undefined.
               ^-- SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
```

Installed `ShellCheck` in VS Code (need to spend some more dedicated time setting up neovim...)

Here are my fixes using the `ShellCheck` linter:

```
#!/bin/sh
## Example: a typical script with several problems
for f in *.m3u
do
  [ -e "$f" ] || break  # handle the case of no *.m3u files
  grep -qi "hq.*mp3" "$f" \
    && printf "Playlist %s contains a HQ file in mp3 format\n" "$f"
done
```

Tests:

```
$ echo "hq.mp3" > test.m3u
$ bash test.sh
Playlist test.m3u contains a HQ file in mp3 format
$ shellcheck test.sh
```

#### Exercise 4

Read article, installed `rr` and followed [this tutorial about using `rr` with an example C++ program](https://undo.io/resources/gdb-watchpoint/time-travel-debugging-rr-debugger/).