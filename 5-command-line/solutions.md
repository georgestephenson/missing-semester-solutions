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