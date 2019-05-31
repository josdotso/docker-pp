# docker-pp

Dockerfile for [pp](https://github.com/CDSoft/pp), the generic preprocessor for [Pandoc](https://www.pandoc.org/).

Based on: https://github.com/CDSoft/pp


## Docker Image

https://hub.docker.com/r/josdotso/pp


## Usage

### Running `pp`

```bash
pp="docker run --rm -it josdotso/pp"

${pp} --help
```

### Accessing Files

To use this image effectively, you should mount directories from the host machine into the container. To do this with `docker run`, see the `-v` argument in `docker run --help`.

```
  -v, --volume list                    Bind mount a volume
```

### Running `pandoc` with [pandoc-latex-template](https://github.com/Wandmalfarbe/pandoc-latex-template):

```bash
pandoc="docker run --rm --entrypoint pandoc -v ${PWD}:/opt -it josdotso/pp"

${pandoc} /opt/example.md -o /opt/example.pdf --from markdown --template eisvogel --listings
```

ref: https://github.com/Wandmalfarbe/pandoc-latex-template#usage


## Bonus Material

The following projects are embedded in this container image for your convenience:

* https://github.com/Wandmalfarbe/pandoc-latex-template
* https://github.com/jgm/pandoc
* https://www.tug.org/texlive/ (basic scheme)
