all: build/dotenv-prod build/dotenv-debug

build/dotenv-prod: build dotenv/*.pony
	ponyc dotenv/test -o build -b dotenv-prod

build/dotenv-debug: build dotenv/*.pony
	ponyc dotenv/test -o build -b dotenv-debug --debug

build:
	mkdir build

test: build/dotenv-prod build/dotenv-debug
	build/dotenv-prod
	build/dotenv-debug

clean:
	rm -rf build

.PHONY: all clean test
