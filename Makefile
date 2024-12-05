.PHONY: build clean f

build: build/notebook.pdf

clean:
	rm build/*.pdf

build/notebook.pdf: media/titlepage.pdf build/content.pdf
	pdfunite $^ $@

build/content.pdf: build/pp.md media/*
	pandoc -t pdf $< -o $@ \
	--template eisvogel \
	--number-sections \
	--eol=native

build/pp.md: notebook.md
	sed "s/{{DATE}}/$(shell date '+%a, %B %d, %Y')/" $^ > $@
	sed -E -i 's/\{\{([^|]+)\|([0-9.]+)\}\}/\\includegraphics[width=\2\\textwidth]{media\/\1}/g' $@