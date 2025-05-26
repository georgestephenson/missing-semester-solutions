# Porpourri

## Notes 

### Keyboard remapping

Keymappings - certainly there are lots of keys on the keyboard that I and most people never use likes Caps Lock. The could be remapped for more efficient keyboard input.

### Daemons

Daemons - background processes, names end with `d` like `sshd` and `systemd`.

Creating your own daemons using `systemd`, quite a simple accessible interface for doing this.

`cron` - running programs on a schedule, I'm familiar with the `cron` scheduling syntax.

### FUSE

Filesystem in User Space, run user space code to implement filesystems interface in the kernel however you want. E.g. `sshfs` - open files remotely as if they were local. `rclone` - mount Dropbox etc. `gocryptfs` - mount encrypted files but view them as plaintext.

### Backups

Backups - good point about cloud storage simply propogating changes to your local copy, and if something gets corrupted or deleted, it will copy that too. You need a proper backup solution to have versioning, deduplication (like with Git's DAG, changes are stored incrementally and efficiently), security.

### Command line flags/patterns

In a command's arguments use `--` to tell the program to stop interpreting arguments as flags if they happen to look like flags like `-r`.

### VPNs

VPN is really just changing internet service provider, why should you trust the VPN provider with your data more than your actual ISP.

Question asked in the lecture about public wi-fi networks having unencrypted traffic - solution would be to have DNS over TLS or DNS over HTTPS - according to Wikipedia, Firefox and Chrome do DNS over HTTPS by default since 2020.

### Markdown

Didn't know you can specify a language after backticks ``` to get syntax highlighting for that language.

**C#**

``` C#
Console.WriteLine("Hello, World!");
```

**Python**

``` Python
for num in range(1, 101):
    if num % 3 == 0 and num % 5 == 0:
        print('FizzBuzz')
    elif num % 3 == 0:
        print('Fizz')
    elif num % 5 == 0:
        print('Buzz')
    else:
        print(num)
```

### VMs, Docker, etc.

Vagrant - tool that is like Docker but for managing VM configurations with code that can then be operated with simple commands like `vargrant up`.