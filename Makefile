.PHONY: build

build: notebook.pdf

notebook.pdf: media/titlepage.pdf media/content.pdf
	pdfunite media/titlepage.pdf media/content.pdf notebook.pdf

media/content.pdf: notebook.md media/*
	pandoc -t pdf notebook.md -o media/content.pdf \
	--template eisvogel \
	--number-sections \
	--resource-path=./media \
	--eol=native \
	--strip-comments