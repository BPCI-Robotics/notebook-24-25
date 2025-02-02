.PHONY: build clean f

build: build/notebook.pdf

clean:
	rm build/*.pdf

build/notebook.pdf: media/titlepage.pdf build/content.pdf
	pdfunite $^ $@
	echo "Sections which need to be completed:"
	grep "{{TODO}}" -B 5 -A 5 -n notebook.md || true

build/content.pdf: build/pp.md media/*
	pandoc -t pdf $< -o $@ --template eisvogel --number-sections

build/pp.md: notebook.md
	sed "s/{{DATE}}/$(shell date '+%a, %B %d, %Y')/" $^ > $@
	sed -E -i 's/\{\{([^|]+)\|([0-9.]+)\}\}/\\includegraphics[width=\2\\textwidth]{media\/\1}/g' $@