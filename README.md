# docker-pp

Dockerfile for [pp](https://github.com/CDSoft/pp), the generic preprocessor for [Pandoc](https://www.pandoc.org/).

Based on: https://github.com/CDSoft/pp

## Docker Image

https://hub.docker.com/r/josdotso/pp

## Usage

```bash
docker run --rm -it josdotso/pp --help
```

To use this image effectively, you should mount directories from the host machine into the container. To do this with `docker run`, see the `-v` argument in `docker run --help`.

```
  -v, --volume list                    Bind mount a volume
```

## Bonus Material

The following projects are embedded in this container image for your convenience:

* https://github.com/Wandmalfarbe/pandoc-latex-template
