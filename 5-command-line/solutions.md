# Command-line Environment

## Notes

This particular lecture covers A LOT of ground.

- Fundamental knowledge about how jobs, processes and signals work in Unix/Linux programs
- Terminal multiplexers enabling truly versatile and visual multi-tasking within terminal windows
- Aliases for command shortcuts
- Dotfiles for configuring your shell and other programs to add features and boost productivity
- Remote machines, SSH

## Solutions

### Terminal multiplexer

#### Exercise 1

Followed the [recommended tutorial](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/) and configured a `.tmux.conf`

```
# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Enable mouse control (clickable windows, panes, resizable panes)
set -g mouse on
```

### Aliases

#### Exercise 1

```
alias dc=cd
```

#### Exercise 2

Checked history, didn't find too many useful aliases to setup. Need to setup some git aliases, though.

### Dotfiles

#### Exercises 1-6

I found [chezmoi](https://github.com/twpayne/chezmoi) quite easy to quick start and setup so I'm using that to manage my few linux tool configs so far (bash, git, tmux, vim).

I published the `chezmoi` managed repo to my GitHub.

https://github.com/georgestephenson/dotfiles

### Remote Machines

Installed VirtualBox and VM with Ubuntu Server 24.04.2.

#### Exercise 1

```
Your identification has been saved in /home/george-stephenson/.ssh/id_ed25519
Your public key has been saved in /home/george-stephenson/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:iBAEi2EAU/LV9lelB1LzneXIkVXLOVrYd8E/0a6yDzw gste@vostro-5590
The key's randomart image is:
+--[ED25519 256]--+
|X=+ ..    ..+.++*|
|o* o  o    ..*=BB|
|o o  . .   ...=XB|
|   . . .. .  .o.*|
|    . . S.   . ..|
|           .. .  |
|            Eo   |
|            .o   |
|             ..  |
+----[SHA256]-----+

```

#### Exercise 2

Edited `.ssh/config`

```
 Host vm
     User gste
     HostName 127.0.0.1
     Port 2522
     IdentityFile ~/.ssh/id_ed25519
     LocalForward 9999 localhost:8888
```

#### Exercise 3

```
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
gste@127.0.0.1's password: 

Number of key(s) added: 1
```

#### Exercise 4

```
gste@ubuntu-server-24:~$ python -m http.server 8888
Serving HTTP on 0.0.0.0 port 8888 (http://0.0.0.0:8888/) ...
```

```
gste@vostro-5590:~/.ssh$ curl http://localhost:9999
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Directory listing for /</title>
</head>
<body>
<h1>Directory listing for /</h1>
<hr>
<ul>
<li><a href=".bash_history">.bash_history</a></li>
<li><a href=".bash_logout">.bash_logout</a></li>
<li><a href=".bashrc">.bashrc</a></li>
<li><a href=".cache/">.cache/</a></li>
<li><a href=".profile">.profile</a></li>
<li><a href=".ssh/">.ssh/</a></li>
<li><a href=".sudo_as_admin_successful">.sudo_as_admin_successful</a></li>
</ul>
<hr>
</body>
</html>
```

#### Exercise 5

Done

#### Exercise 6

Installed `mosh` on client and server.

Had to switch from NAT to 'Bridged Adapter' network adapter in VirtualBox to get `mosh` to connect.

Tried disabling during the `mosh` session by switching network to 'No Adapter'... Ubuntu Server would no longer boot after I did this...

But I was able to run this on the server

```
sudo ip link set enp0s3 down
sudo ip link set enp0s3 up
```

The mosh session was able to reconnect automatically when the network was restored.

#### Exercise 7

Running this command:

```
ssh -Nf vm
```

Enables background port forwarding as a background `ssh` process. If we have the previous example web server running on the vm using `python -m http.server 8888`, the background port forwarding means `http://localhost:9999` is available.

If we `kill` the background `ssh` process, `http://localhost:9999` is no longer available.