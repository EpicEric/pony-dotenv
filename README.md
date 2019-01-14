# pony-dotenv

[Ponylang](https://ponylang.io) library to load environment variables from a `.env` file when running in debug mode.

Based on the [Node package](https://github.com/motdotla/dotenv).

## Status

[![CircleCI](https://circleci.com/gh/EpicEric/pony-dotenv.svg?style=svg)](https://circleci.com/gh/EpicEric/pony-dotenv)

Development underway; this package still doesn't work.

### Implemented features

* Always return the original `Env` in a production environment.
* Run debug and production tests.

### Planned features

* Add `.env` vars to new `Env`.
* Ignore comments and empty lines.
* (?) Allow multiline values.

## Installation

* Install [pony-stable](https://github.com/ponylang/pony-stable)
* Update your `bundle.json`

```json
{ 
  "type": "github",
  "repo": "EpicEric/pony-dotenv"
}
```

* `stable fetch` to fetch your dependencies
* `use "dotenv"` to include this package
* `stable env ponyc` to compile your application
