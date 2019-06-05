.DEFAULT_GOAL := help

OUT_NAME = tech-doc

DIR_NAME := $(PWD)
DIST_DIR = dist
BUILD_DIR = build
TEMPLATE = ~/.pandoc/templates/eisvogel.latex

#######################################
# Docker-Based Build Targets

all: check  ## Makes all documentation formats
	docker run -v $(DIR_NAME):/doc --entrypoint "/bin/bash" --rm -it josdotso/pp:latest -c 'cd /doc && make _$@'

html: check ## Makes HTML sources
	docker run -v $(DIR_NAME):/doc --entrypoint "/bin/bash" --rm -it josdotso/pp:latest -c 'cd /doc && make _$@'

pdf: check  ## Makes a PDF
	docker run -v $(DIR_NAME):/doc --entrypoint "/bin/bash" --rm -it josdotso/pp:latest -c 'cd /doc && make _$@'

#######################################
# Local Private Build Targets

_all: _html _pdf

_html: $(DIST_DIR)/html/$(OUT_NAME).html

_pdf: $(DIST_DIR)/pdf/$(OUT_NAME).pdf

#######################################
# Core Logic

$(BUILD_DIR)/main.md: main.md
	mkdir -p $(BUILD_DIR)
	pp main.md > $(BUILD_DIR)/main.md

$(DIST_DIR)/html/$(OUT_NAME).html: $(BUILD_DIR)/$(OUT_NAME).tex
	mkdir -p $(DIST_DIR)/html
	pandoc \
	  --from latex \
	  --to html5 \
	  --listings \
	  -o $(DIST_DIR)/html/$(OUT_NAME).html \
	  $(BUILD_DIR)/$(OUT_NAME).tex
	rsync -a --prune-empty-dirs --include '*/' --include '*.svg' --exclude '*' $(BUILD_DIR)/ $(DIST_DIR)/html
	sed -i 's@$(BUILD_DIR)/@@g' dist/html/$(OUT_NAME).html

$(DIST_DIR)/pdf/$(OUT_NAME).pdf: $(BUILD_DIR)/main.md
	mkdir -p $(DIST_DIR)/pdf
	pandoc \
	  --from markdown \
	  --to latex \
	  --template $(TEMPLATE) \
	  --listings \
	  -o $(DIST_DIR)/pdf/$(OUT_NAME).pdf \
	  $(BUILD_DIR)/main.md

$(BUILD_DIR)/$(OUT_NAME).tex: $(BUILD_DIR)/main.md
	pandoc \
	  --from markdown \
	  --to latex \
	  --template $(TEMPLATE) \
	  --listings \
	  -o $(BUILD_DIR)/$(OUT_NAME).tex \
	  $(BUILD_DIR)/main.md

check:
	@if ! which docker 2>&1 > /dev/null; then \
	  echo "ERROR: Docker must be installed as a dependency"; \
	fi
clean:  ## Cleans all temprary files
	rm -rf $(BUILD_DIR) $(DIST_DIR)

help:  ## Print list of Makefile targets
	@# Taken from https://github.com/spf13/hugo/blob/master/Makefile
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  cut -d ":" -f1- | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
