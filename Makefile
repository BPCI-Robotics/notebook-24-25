.PHONY: build view

build: notebook.pdf

view: notebook.pdf
	mupdf notebook.pdf

notebook.pdf: titlepage.pdf content.pdf
	pdfunite titlepage.pdf content.pdf notebook.pdf

content.pdf: notebook.md
	pandoc -t pdf notebook.md --template eisvogel -o content.pdf
