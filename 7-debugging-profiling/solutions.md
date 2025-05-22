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


### Profiling

#### Exercise 5

I added this to the script

```
import cProfile
...
print('Insertion sort runtime')
cProfile.run('test_sorted(insertionsort)')
print('Quick sort runtime')
cProfile.run('test_sorted(quicksort)')
```

Which returned

```
Insertion sort runtime
         211068 function calls in 0.051 seconds

   Ordered by: standard name

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.051    0.051 <string>:1(<module>)
    25199    0.008    0.000    0.013    0.000 random.py:242(_randbelow_with_getrandbits)
    25199    0.013    0.000    0.031    0.000 random.py:291(randrange)
    25199    0.006    0.000    0.036    0.000 random.py:332(randint)
     1000    0.010    0.000    0.010    0.000 sorts.py:11(insertionsort)
        1    0.005    0.005    0.051    0.051 sorts.py:4(test_sorted)
    75597    0.005    0.000    0.005    0.000 {built-in method _operator.index}
        1    0.000    0.000    0.051    0.051 {built-in method builtins.exec}
     1000    0.000    0.000    0.000    0.000 {built-in method builtins.len}
     1000    0.000    0.000    0.000    0.000 {built-in method builtins.sorted}
    25199    0.002    0.000    0.002    0.000 {method 'bit_length' of 'int' objects}
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
    31671    0.002    0.000    0.002    0.000 {method 'getrandbits' of '_random.Random' objects}


Quick sort runtime
         276514 function calls (244556 primitive calls) in 0.067 seconds

   Ordered by: standard name

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.067    0.067 <string>:1(<module>)
    25354    0.009    0.000    0.014    0.000 random.py:242(_randbelow_with_getrandbits)
    25354    0.013    0.000    0.032    0.000 random.py:291(randrange)
    25354    0.006    0.000    0.038    0.000 random.py:332(randint)
32958/1000    0.021    0.000    0.023    0.000 sorts.py:23(quicksort)
        1    0.005    0.005    0.067    0.067 sorts.py:4(test_sorted)
    76062    0.005    0.000    0.005    0.000 {built-in method _operator.index}
        1    0.000    0.000    0.067    0.067 {built-in method builtins.exec}
    32958    0.002    0.000    0.002    0.000 {built-in method builtins.len}
     1000    0.001    0.000    0.001    0.000 {built-in method builtins.sorted}
    25354    0.002    0.000    0.002    0.000 {method 'bit_length' of 'int' objects}
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
    32116    0.003    0.000    0.003    0.000 {method 'getrandbits' of '_random.Random' objects}
```

Using `line_profiler`:

```
Total time: 0.0798094 s
File: /home/gste/test-sandbox/sorts.py
Function: quicksort at line 23

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    23                                           @profile
    24                                           def quicksort(array):
    25     33720    6729081.0    199.6      8.4      if len(array) <= 1:
    26     17360    3137740.0    180.7      3.9          return array
    27     16360    2486895.0    152.0      3.1      pivot = array[0]
    28    123780   27014840.0    218.2     33.8      left = [i for i in array[1:] if i < pivot]
    29    123780   26689036.0    215.6     33.4      right = [i for i in array[1:] if i >= pivot]
    30     16360   13751806.0    840.6     17.2      return quicksort(left) + [pivot] + quicksort(right)

Total time: 0.117335 s
File: /home/gste/test-sandbox/sorts.py
Function: insertionsort at line 11

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    11                                           @profile
    12                                           def insertionsort(array):
    13                                           
    14     26462    4122407.0    155.8      3.5      for i in range(len(array)):
    15     25462    3783506.0    148.6      3.2          j = i-1
    16     25462    3714956.0    145.9      3.2          v = array[i]
    17    231049   43347718.0    187.6     36.9          while j >= 0 and v < array[j]:
    18    205587   29312682.0    142.6     25.0              array[j+1] = array[j]
    19    205587   28929206.0    140.7     24.7              j -= 1
    20     25462    3777707.0    148.4      3.2          array[j+1] = v
    21      1000     347173.0    347.2      0.3      return array

```

`cProfile` suggests insertion sort is faster, but `line_profiler` suggests quicksort is faster. The bottleneck in quicksort is product the recursive `left` and `right` lists. The bottleneck in insertion sort is looping and swapping array values. The list allocation overheads in the quicksort are making it slower overall even the `line_profiler` suggests the core algorithm within the quicksort method is faster.

Using `memory_profiler` - only got this to profile `test-sorted`. With quicksort:

```
Line #    Mem usage    Increment  Occurrences   Line Contents
=============================================================
     4     23.2 MiB     23.2 MiB           1   @profile
     5                                         def test_sorted(fn, iters=1000):
     6     23.2 MiB      0.0 MiB        1001       for i in range(iters):
     7     23.2 MiB      0.0 MiB       26154           l = [random.randint(0, 100) for i in range(0, random.randint(0, 50))]
     8     23.2 MiB      0.0 MiB        1000           assert fn(l) == sorted(l)
     9                                                 # print(fn.__name__, fn(l))
```

With insertion sort:

```
Line #    Mem usage    Increment  Occurrences   Line Contents
=============================================================
     4     23.1 MiB     23.1 MiB           1   @profile
     5                                         def test_sorted(fn, iters=1000):
     6     23.1 MiB      0.0 MiB        1001       for i in range(iters):
     7     23.1 MiB      0.0 MiB       25202           l = [random.randint(0, 100) for i in range(0, random.randint(0, 50))]
     8     23.1 MiB      0.0 MiB        1000           assert fn(l) == sorted(l)
     9                                                 # print(fn.__name__, fn(l))
```

Only slightly better but likely because it's without the list allocations.

Inplace quicksort:

```
Line #    Mem usage    Increment  Occurrences   Line Contents
=============================================================
     4     23.1 MiB     23.1 MiB           1   @profile
     5                                         def test_sorted(fn, iters=1000):
     6     23.1 MiB      0.0 MiB        1001       for i in range(iters):
     7     23.1 MiB      0.0 MiB       26424           l = [random.randint(0, 100) for i in range(0, random.randint(0, 50))]
     8     23.1 MiB      0.0 MiB        1000           assert fn(l) == sorted(l)
     9                                                 # print(fn.__name__, fn(l))
```

Using `perf`:

```
$ sudo perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations python sorts.py
```

Insertion sort

```
 Performance counter stats for 'python sorts.py':

         3,800,697      cache-references                                                      
           297,994      cache-misses                     #    7.84% of all cache refs         
       141,628,579      cycles                                                                
       324,832,375      instructions                     #    2.29  insn per cycle            
        55,293,319      branches                                                              
             1,168      faults                                                                
                 0      migrations                                                            

       0.057253872 seconds time elapsed

       0.052234000 seconds user
       0.005022000 seconds sys
```

Quicksort

```
 Performance counter stats for 'python sorts.py':

         4,165,563      cache-references                                                      
           288,810      cache-misses                     #    6.93% of all cache refs         
       163,877,707      cycles                                                                
       331,123,658      instructions                     #    2.02  insn per cycle            
        59,958,508      branches                                                              
             1,167      faults                                                                
                 0      migrations                                                            

       0.049978298 seconds time elapsed

       0.045010000 seconds user
       0.005001000 seconds sys
```

Inplace quicksort

```
 Performance counter stats for 'python sorts.py':

         4,037,259      cache-references                                                      
           327,975      cache-misses                     #    8.12% of all cache refs         
       137,640,197      cycles                                                                
       292,619,829      instructions                     #    2.13  insn per cycle            
        51,921,192      branches                                                              
             1,168      faults                                                                
                 0      migrations                                                            

       0.050204059 seconds time elapsed

       0.045188000 seconds user
       0.005020000 seconds sys
```

#### Exercise 6

According to the `pycallgraph.png`, `fib0` is called 21 times.

With memoization, each `fibN` function is now called 1 time.

#### Exercise 7

In first terminal

```
$ python -m http.server 4444
Serving HTTP on 0.0.0.0 port 4444 (http://0.0.0.0:4444/) ...
```

In other terminal

```
$ lsof | grep "4444 (LISTEN)"
python    5712                                gste    3u     IPv4              33493       0t0      TCP *:4444 (LISTEN)
$ kill 5712
```

In first terminal again

```
Terminated
```

#### Exercise 8

`taskset --cpu-list 0,2 stress -c 3` when running this command, we are specifying that that process must only run on CPU #0 and #2. `stress -c 3` creates 3 workers but they must be split between the two CPUs, so `htop` show's the CPUs running them at 66.6% CPU load on average. 

Using `cgroups`

```
$ sudo mkdir /sys/fs/cgroup/stress
$ echo 0,2 | sudo tee /sys/fs/cgroup/stress/cpuset.cpus

$ echo $$ | sudo tee /sys/fs/cgroup/stress/cgroup.procs
exec stress -c 3
5693
stress: info: [5693] dispatching hogs: 3 cpu, 0 io, 0 vm, 0 hdd
```

Limiting memory consumption

```
$ sudo mkdir /sys/fs/cgroup/memtest
$ echo 128M | sudo tee /sys/fs/cgroup/memtest/memory.max
$ echo $$ | sudo tee /sys/fs/cgroup/memtest/cgroup.procs
$ exec stress -m 3
```

Viewing `htop`, each `stress` worker has a RES around 43MB.

#### Exercise 9

Sniffing packets in Wireshark, after running the `curl` command I am able to see a GET HTTP request and a 200 OK response.