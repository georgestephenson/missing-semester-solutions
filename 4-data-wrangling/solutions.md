# Data Wrangling

## Solutions

### Exercise 1

Completed regex tutorial at [RegexOne](https://regexone.com/).

### Exercise 2

Words that contain at least three `a`s and don't have a `'s` ending:

```
cat /usr/share/dict/words
 | grep -E -i '.*(a.*){3,}'
 | grep -v "'s$"
```

Find the top three most common last two letters of those words:

```
cat /usr/share/dict/words
 | grep -E -i '.*(a.*){3,}'
 | grep -v "'s$"
 | sed -E 's/.*(.{2})/\1/'
 | sort | uniq -ic
 | sort -r -nk1,1 | head -n3
```

This gives us:

```
    101 an
     63 ns
     54 as
```

Number of unique two-letter endings:

```
cat /usr/share/dict/words
 | grep -E -i '.*(a.*){3,}'
 | grep -v "'s$"
 | sed -E 's/.*(.{2})/\1/'
 | sort | uniq -i | wc -l
```

Result:

```
112
```

To find out which combinations do not occur, generate all possible pairs, and then exclude pairs that occur in our original set.

```
cat /usr/share/dict/words | grep -E -i '.*(a.*){3,}' | grep -v "'s$"  | sed -E 's/.*(.{2})/\1/' | sort > word_endings.txt

for i in {a..z} ; do
  for j in {a..z} ; do
    echo $i$j
  done
done > all_endings.txt

comm -2 -3 all_endings.txt word_endings.txt
```

### Exercise 3

The `>` command will erase `input.txt` before `sed` reads it. The output of `sed` written to `input.txt` will then be empty.

```
$ echo "REGEX" > input.txt
$ sed -i s/REGEX/SUBSTITUTION/ input.txt > input.txt
$ wc input.txt
0 0 0 input.txt
```

You can use `sed`'s `-i` option to edit files in place and avoid using `>`.

```
$ echo "REGEX" > input.txt
$ sed -i s/REGEX/SUBSTITUTION/ input.txt
$ cat input.txt
SUBSTITUTION
```

### Exercise 4

I am using `Ubuntu 24.04.2` and used the following commands to get boot logs. I also installed `dateutils` to use `datediff` and `r-base-core` to use `R`.

```
journalctl -o short-iso | grep -E "kernel: Command line" | cut -c-26 > bootstarts.txt

journalctl -o short-iso | grep -E "systemd\[1\]: Startup finished" | cut -c-26 > bootends.txt

paste bootstarts.txt bootends.txt |
while IFS=$'\t' read start compl; do
    datediff -f '%0H:%0M:%0S' "$start" "$compl"
done | cut -c7- | R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'
```

This gives the following output:

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  10.00   11.00   11.00   11.34   11.00   22.00 
```

### Exercise 5

I found the instructions slightly unclear on this one.
1. Firstly, we need to get the unique logs for each of the three sets of boot logs (filtering out timestamp). Some logs might occur more than once in a boot, so counting the total across all boots would be meaningless unless we first make the lines for each boot unique.
2. Then we can count which unique logs occur on each boot. If the count is 1 or 2, then the boot message is *not* shared between the past three boots.

```
journalctl -b -2 | cut -c29- | sort | uniq > bootlogs.txt
journalctl -b -1 | cut -c29- | sort | uniq >> bootlogs.txt
journalctl -b 0 | cut -c29- | sort | uniq >> bootlogs.txt
cat bootlogs.txt | sort | uniq -c | grep -E '^\s+[12].*$'
```

### Exercise 6

Getting stats of one column of data - in this case, new Wikipedians per month.

```
$ curl -s https://stats.wikimedia.org/EN/TablesWikipediaZZ.htm \
 | pup 'table#table1 tr td.rb:nth-child(3) text{}' \
 | tail -n +7 \
 | R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      7    5728   14544   12353   17176   24875 
```

Summing columns and getting the difference between the sum of two columns. I'm sure there are many ways to make this into a one line command.

```
$ totalwikipedians=$(curl -s https://stats.wikimedia.org/EN/TablesWikipediaZZ.htm \
 | pup 'table#table1 tr td.rb:nth-child(2) text{}' \
 | tail -n +7 \
 | paste -sd+ | bc -l)

$ newwikipedians=$(curl -s https://stats.wikimedia.org/EN/TablesWikipediaZZ.htm \
 | pup 'table#table1 tr td.rb:nth-child(3) text{}' \
 | tail -n +7 \
 | paste -sd+ | bc -l)

$ echo $((totalwikipedians - $newwikipedians))

2594185
```