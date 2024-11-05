.PHONY: build

build: build/notebook.pdf

clean:
	rm build/*.pdf

build/notebook.pdf: media/titlepage.pdf build/content.pdf
	pdfunite $^ $@

build/content.pdf: notebook.md media/*
	pandoc -t pdf $< -o $@ \
	--template eisvogel \
	--number-sections \
	--resource-path=./media \
	--eol=native \
	--strip-comments