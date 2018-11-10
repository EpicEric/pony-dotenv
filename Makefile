all: build/dotenv-debug build/dotenv-prod

build/dotenv-debug: build dotenv/*.pony
	ponyc dotenv -o build -b dotenv-debug --debug

build/dotenv-prod: build dotenv/*.pony
	ponyc dotenv -o build -b dotenv-prod

build:
	mkdir build

test: build/dotenv-debug build/dotenv-prod
	build/dotenv-debug
	build/dotenv-prod

clean:
	rm -rf build

.PHONY: all clean test
