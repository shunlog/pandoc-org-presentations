talk-file = talk.org

all: talk.html talk.tex talk.pdf talk-handout.pdf talk-notes.pdf

start: talk.html
	sensible-browser $<

talk.html: $(talk-file) reveal.js
	pandoc --standalone --slide-level=2 --to revealjs --css style.css \
		-o ./out/$@ $<

talk.tex: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer -o ./out/$@ $<

talk.pdf: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer \
		--pdf-engine=xelatex \
		-o ./out/$@ $<

talk-notes.pdf: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer \
		--pdf-engine=xelatex \
		--metadata='classoption:notes=only' \
		-o ./out/$@ $<

talk-handout.pdf: $(talk-file)
	pandoc --standalone --to latex \
		--pdf-engine=xelatex \
		-o ./out/$@ $<

reveal.js:
	git submodule update --init

clean:
	git clean -dXf

.PHONY: all clean open
