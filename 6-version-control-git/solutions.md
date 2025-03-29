# Version Control (Git)

## Solutions

### Exercise 1

I have some past experience with Git, however I plan to read through Pro Git.

### Exercise 2

Clone `missing-semester`

```
$ git clone https://github.com/missing-semester/missing-semester.git
$ cd missing-semester/
```

Version history as graph

```
$ git log --all --graph --decorate --oneline
```

Last person to modify `README.md`

```
$ git log -n 1 --format='%an' README.md
```

Commit message associated with last modification to `collections:` line of `_config.yml`

```
$ git blame -L /collections:/,+1 _config.yml
$ git show -s --format=%s a88b4eac
```

### Exercise 3

Git is space-efficient because it only stores the diff of files between versions. This works best for text files. Large binary files like images will not have small incremental diffs between version if they are updated, so the size of the repository will quickly grow.

In Git, commits are immutable so if sensitive data is added, it will remain in the commit history even if removed by later commits. Altering the repository history is possible but difficult and has side effects, it is best to avoid it if possible.

### Exercise 4

Running `git stash` on `main` I see two commits above `HEAD -> main` in `git log --all --online`.

```
ebaeca7 (refs/stash) WIP on main: 4d03edd ...
1aaf6ed index on main: 4d03edd ...
4d03edd (HEAD -> main, origin/main, origin/HEAD) ...
```

Running `git stash pop` puts the graph back as it was before.

```
4d03edd (HEAD -> main, origin/main, origin/HEAD) ...
```

If you're in-between work and your code isn't fully working yet, stash can be useful to quickly switch contexts. However it's often just as easy to commit to a new branch if you're at a meaningful stopping point. Behind the scenes, `stash` is actually more complex than a simple commit on a new branch, it also involves merging.

### Exercise 5

```
$ git config --global alias.graph 'log --all --graph --decorate --oneline'
```

### Exercise 6

```
$ git config --global core.excludesfile ~/.gitignore_global
$ vim ~/.gitignore_global
```

### Exercise 7

I indeed submitted a pull request to the `missing-semester` repository!

[Fix Typos in Editors and Data Wrangling Lecture Notes](https://github.com/missing-semester/missing-semester/pull/307)