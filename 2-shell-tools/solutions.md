# Shell Tools and Scripting

## Solutions

### Exercise 1

```
~/test$ ls -lhat --color=auto
total 3.3M
drwxr-xr-x  6 gste george-stephenson 4.0K Mar  2 14:00 .
-rw-r--r--  1 gste george-stephenson    0 Mar  2 14:00 .hidden-file
drwxr-xr-x  2 gste george-stephenson 4.0K Mar  2 13:56 .hidden-dir
drwxr-x--- 32 gste george-stephenson 4.0K Mar  2 13:55 ..
drwxr-xr-x  2 gste george-stephenson 4.0K Mar  2 13:52 bar
drwxr-xr-x  2 gste george-stephenson 4.0K Mar  2 13:52 baz
drwxr-xr-x  2 gste george-stephenson 4.0K Mar  2 13:52 foo
-rw-r--r--  1 gste george-stephenson 1.2M Feb  8 00:36 blue-marble.jpg
-rw-rw-r--  1 gste george-stephenson 2.1M Feb  1 12:46 ai-history.png
```

### Exercise 2

Source in `marco.sh`:

```
#!/bin/sh
marco() 
{ 
  marcovar=$(pwd); 
}

polo() 
{ 
  cd $marcovar; 
}
```

Test shell functions:

```
~/test$ source marco.sh
~/test$ marco
~/test$ cd ..
$ polo
~/test$ 
```

### Exercise 3

Source in `debug-rarefail.sh`:

```
#!/usr/bin/env bash
runcount=1
./rarefail.sh > rarefailout.log 2> rarefailerr.log
while [ $? -eq 0 ]
do
  runcount=$(( $runcount + 1 ))
  ./rarefail.sh >> rarefailout.log 2>> rarefailerr.log
done

echo "stdout"
cat rarefailout.log
echo ""
echo "stderr"
cat rarefailerr.log
echo ""
echo "number of runs"
echo $runcount
```

Test run:

```
~/projects/missing-semester/2-shell-tools/scripts$ sh debug-rarefail.sh
stdout
Everything went according to plan
Everything went according to plan
Everything went according to plan
Everything went according to plan
Everything went according to plan
Everything went according to plan
Something went wrong

stderr
The error was using magic numbers

number of runs
7
```

### Exercise 4

```
~/test$ find ./ -name "*.html" -exec tar uvf myarchives.tar {} +
~/test$ gzip < myarchives.tar > myarchives.tar.gz
~/test$ tar -tf myarchives.tar.gz
./a.html
./baz/a.html
./baz/b.html
./baz/c.html
./file with spaces.html
./bar/a.html
./bar/b.html
./bar/c.html
./foo/a.html
./foo/b.html
./foo/c.html
```

### Exercise 5

Find the most recently modified file in a directory:

```
~/test$ find . -printf "%T@ %Tc %p\n" | sort -nr | head -n 1
1740928744.9822374690 Sun 02 Mar 2025 15:19:04 GMT ./myarchives.tar.gz
```

List all files by recency:

```
~/test$ find . -printf "%T@ %Tc %p\n" | sort -nr
```