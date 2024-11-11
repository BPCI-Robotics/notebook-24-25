.PHONY: build clean f

build: build/notebook.pdf

# Use this if you are changing the Makefile and want to test it.
f:
	touch notebook.md
	make build

clean:
	rm build/*.pdf

build/notebook.pdf: media/titlepage.pdf build/content.pdf
	pdfunite $^ $@

build/content.pdf: notebook.md media/*
	pandoc -t pdf $< -o $@ \
	--template eisvogel \
	--number-sections \
	--eol=native \
