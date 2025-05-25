# Metaprogramming

## Solutions 

### Exercise 1

The simplest example of a `clean` target in this makefile:

```
.PHONY: clean
clean:
	rm -f paper.pdf plot-*.png
```

### Exercise 2

Use cases for different version requirements for dependencies in Rust's build system:

- Caret (`^`), default versioning, allows minor/patch updates. This is the default as any minor/patch updates should be compatible with your code while taking advantage of the latest updates to the dependency, like performance improvements and security fixes.
- Tilde (`~`), only patch-level updates allowed. Makes sense if you want to update to the latest security patch as soon as possible, but do not want to risk the more significant enhancements made with minor versions breaking your code, so is more "conservative".
- Wildcard (`*`), any version at a semantic level, could be major, minor or patch-level. For patch-level, any version *should* work, you may want to make the most efficient use of existing installed dependencies. 

  At a minor-level, you may only be using minor version 0 functionality, but later minor versions are better supported with patches, so you use `*` to take advantage of the most recent minor version updates.

  At a major-level a bare `*` version doesn't make much sense as later versions can have breaking changes. But a potential use case could be that the project may be highly experimental and using a "fail fast" approach to CI/CD and maximising speed of updating dependencies. If a build or tests fail due to a major-updated dependency, you want to incorporate the new version and fix your build as soon as possible.
- Comparison, manually specifying version ranges. As mentioned with caret, there may be bugs you've noticed with specific versions, for example before or after a specific patch version.
- Multiple, manually specifying any of multiple version ranges. This could be a bug in a version that was introduced with one patch, e.g. 4.2.3, and fixed in a later patch, e.g. 4.3.6. So you might specify `< 4.2.2, >= 4.3.6` any `4.3` version without the bug is fine.

### Exercise 3

For testing that a command runs, the pre-commit can be as simple as running the command as any failure in the command will stop the commit.

```
#!/bin/sh
make --directory ./8-metaprogramming/files
```

### Exercise 4

Rather than creating a new repository for this exercise, I created a GitHub Pages for this repository, [`missing-semester-solutions`](https://georgestephenson.github.io/missing-semester-solutions/). Ah, respository inception, marvellous.

I added the following job to the existing website workflow, as suggested:

```
  shellcheck:
    name: Shellcheck
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run ShellCheck
        uses: ludeeus/action-shellcheck@master
```

It wasn't specified that this is a pre-requisite before we can build and deploy the website, which we could specify in the `.yml`, actually it runs in parallel.

In my case it fails on some scripts I have in `./2-shell-tools/scripts/`:

```
./2-shell-tools/scripts/debug-rarefail.sh:4:9: note: Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
./2-shell-tools/scripts/debug-rarefail.sh:6:16: note: $/${} is unnecessary on arithmetic variables. [SC2004]
./2-shell-tools/scripts/marco.sh:9:3: warning: Use 'cd ... || exit' or 'cd ... || return' in case cd fails. [SC2164]
./2-shell-tools/scripts/marco.sh:9:6: note: Double quote to prevent globbing and word splitting. [SC2086]
Error: Process completed with exit code 1.
```

Well fixing them wasn't part of the exercise!