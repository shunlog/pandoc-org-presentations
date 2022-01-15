talk-file = talk.org

all: talk.html talk.tex talk.pdf talk-handout.pdf talk-notes.pdf

start: talk.html
	sensible-browser $<

talk.html: $(talk-file) reveal.js
	pandoc --standalone --slide-level=2 --to revealjs --css style.css \
		-S -o $@ $<

talk.tex: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer -o $@ $<

talk.pdf: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer \
		-o $@ $<
		--pdf-engine=xelatex \

talk-notes.pdf: $(talk-file)
	pandoc --standalone --slide-level=2 --to beamer \
		--pdf-engine=xelatex \
		--metadata='classoption:notes=only' \
		-o $@ $<

talk-handout.pdf: $(talk-file)
	pandoc --standalone --to latex \
		-o $@ $<
		--pdf-engine=xelatex \

reveal.js:
	git submodule update --init

clean:
	git clean -dXf

.PHONY: all clean open
