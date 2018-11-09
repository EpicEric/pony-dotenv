build/dotenv: build dotenv/*.pony
	ponyc dotenv -o build --debug

build:
	mkdir build

test: build/dotenv
	build/dotenv

clean:
	rm -rf build

.PHONY: clean test
