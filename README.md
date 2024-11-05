# notebook-24-25
Engineering notebook source code for B(ro)botics.

To build this, you need `pandoc`, `texlive-full` and [this template](https://github.com/Wandmalfarbe/pandoc-latex-template).

Run these commands to install what you need.
```sh
sudo apt install make texlive-full pandoc

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

Then simply run `make`. The result will be in `build/notebook.pdf`