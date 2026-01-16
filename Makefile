all:
	elm make src/Main.elm
	mkdir build -p
	cp index.html build/index.html
	cp resources build/resources -rf
.PHONY: clean
clean:
	rm index.html
	rm build -r
	rm elm-stuff -r
