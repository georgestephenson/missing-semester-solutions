# Metaprogramming

## Solutions 

### Exercise 1

The simplest example of a `clean` target in this makefile:

```
.PHONY: clean
clean:
	rm -f paper.pdf plot-*.png
```