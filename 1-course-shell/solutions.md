# Course overview + the shell

## Solutions

### Exercise 1

```
$ echo $SHELL
/bin/bash
```

### Exercise 2

```
$ mkdir /tmp/missing
$ ls /tmp | grep missing
missing
```

### Exercise 3

```
$ man touch
```

### Exercise 4

```
$ touch /tmp/missing/semester
$ ls /tmp/missing
semester
```

### Exercise 5

```
$ echo '#!/bin/sh' > /tmp/missing/semester 
$ echo 'curl --head --silent https://missing.csail.mit.edu' >> /tmp/missing/semester 
$ cat /tmp/missing/semester 
#!/bin/sh
curl --head --silent https://missing.csail.mit.edu
```

### Exercise 6

```
/tmp/missing$ ./semester
bash: ./semester: Permission denied
/tmp/missing$ ls -l
total 4
-rw-r--r-- 1 gste george-stephenson 61 Mar  2 12:27 semester
```

In `-rw-r--r--`, the fourth char `-` means my user does not have 'execute' permission on `semester`.

### Exercise 7

```
/tmp/missing$ sh semester
HTTP/2 200 
server: GitHub.com
content-type: text/html; charset=utf-8
last-modified: Sat, 01 Feb 2025 18:13:13 GMT
access-control-allow-origin: *
etag: "679e6439-205d"
expires: Sun, 02 Mar 2025 12:44:58 GMT
cache-control: max-age=600
x-proxy-cache: MISS
x-github-request-id: 8383:D7FA0:17C113D:17EFFFB:67C45072
accept-ranges: bytes
age: 94
date: Sun, 02 Mar 2025 12:36:32 GMT
via: 1.1 varnish
x-served-by: cache-lcy-eglc8600033-LCY
x-cache: HIT
x-cache-hits: 0
x-timer: S1740918992.351844,VS0,VE1
vary: Accept-Encoding
x-fastly-request-id: 459c09520121497e63c42b70faff8a230c5b915e
content-length: 8285
```

This works because my user has permission to execute `sh` and permission to read `semester` and pass it to `sh`.

```
/tmp/missing$ ls -l $(which sh)
lrwxrwxrwx 1 root root 4 Mar 31  2024 /usr/bin/sh -> dash
```

`lrwxrwxrwx` means all permissions are active on the symbolic link `sh`.

### Exercise 8

```
/tmp/missing$ man chmod
```

### Exercise 9

```
/tmp/missing$ chmod u+x semester
/tmp/missing$ ./semester
HTTP/2 200 
server: GitHub.com
content-type: text/html; charset=utf-8
last-modified: Sat, 01 Feb 2025 18:13:13 GMT
access-control-allow-origin: *
etag: "679e6439-205d"
expires: Sun, 02 Mar 2025 12:44:58 GMT
cache-control: max-age=600
x-proxy-cache: MISS
x-github-request-id: 8383:D7FA0:17C113D:17EFFFB:67C45072
accept-ranges: bytes
age: 0
date: Sun, 02 Mar 2025 12:45:18 GMT
via: 1.1 varnish
x-served-by: cache-lcy-eglc8600054-LCY
x-cache: HIT
x-cache-hits: 0
x-timer: S1740919518.282321,VS0,VE89
vary: Accept-Encoding
x-fastly-request-id: a32ccb55f644ebe1ae0e4ff7bccfd13d541ac696
content-length: 8285
```

### Exercise 10

```
/tmp/missing$ ./semester | grep last-modified | cut -c 16- > ~/last-modified.txt
/tmp/missing$ cat ~/last-modified.txt
Sat, 01 Feb 2025 18:13:13 GMT
```

### Exercise 11

```
$ echo "Charge now is" `cat /sys/class/power_supply/BAT0/charge_now` "out of" `cat /sys/class/power_supply/BAT0/charge_full`
Charge now is 2807000 out of 2807000
```