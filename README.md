# notebook-24-25
Engineering notebook source code for B(ro)botics.

## Building
To build this, you need `pandoc`, `texlive-full` and [this template](https://github.com/Wandmalfarbe/pandoc-latex-template).

Run these commands to install what you need.
```sh
# WARNING: texlive-full is 5 GB!!
sudo apt install make texlive-full pandoc poppler-utils

templates_dir="$(pandoc --version | grep "User data" | sed "s/User data directory: //")/templates"
mkdir --parents ${templates_dir}

mkdir eisvogel
cd eisvogel
wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.5.0/Eisvogel-2.5.0.tar.gz
tar xzvf *.tar.gz
cp eisvogel.latex ${templates_dir}
cd ..
rm eisvogel -r
```

Then simply run `make`. The result will be in `build/notebook.pdf`.

You can also use `tlmgr` to get this to work. There is no need to update it.

## Special syntax
Using some simple commands, custom syntax is added to the notebook to make it easier to write. This section may change.
* `{{TODO}}` will make that part of the text print when the notebook is being compiled. This shows which sections need to be worked on.
* `{{image.png|0.8}}` will expand to `\includegraphics[width=0.8\pagewidth]{media/image.png}`. The reason that we are not using the standard `![](image.png)` markdown syntax is because when changing the width, it only scales in one direction. No point in finding a fix now because this solution is easy to use.
* `{{DATE}}` will print the date in a specific format, e.g. `Wed, December 5, 2024`. This is only used for the date header and is not useful anywhere else.

## How does it work
`sed` is used to convert the special syntax into proper LaTeX and markdown. `pandoc` is used to convert markdown files to PDF. `pandoc-latex-template` is used to provide better-looking defaults, so the output looks much better. This is built to `build/content.pdf`. Then, `pdfunite` from `poppler-utils` is used to combine the cover page with the rest of the document.
