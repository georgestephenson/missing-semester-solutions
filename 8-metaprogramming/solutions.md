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