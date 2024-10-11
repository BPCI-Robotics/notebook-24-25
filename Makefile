.PHONY: build

build: notebook.pdf

notebook.pdf: media/titlepage.pdf content.pdf
	pdfunite media/titlepage.pdf content.pdf notebook.pdf

content.pdf: notebook.md media/*
	pandoc -t pdf notebook.md -o content.pdf \
	--template eisvogel \
	--number-sections \
	--resource-path=./media \
	--eol=native \
	--strip-comments