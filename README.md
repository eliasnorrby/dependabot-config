# Dependabot Config

[![Travis][travis-badge]][travis-link]
[![npm][npm-badge]][npm-link]

[![Dependabot Status][dependabot-badge]][dependabot-link]
[![semantic-release][semantic-release-badge]][semantic-release-link]

A simple script for writing a dependabot configuration file to a project.

# Setup

## Using `npx`

Run the following command to write the configuration file

```sh
npx @eliasnorrby/dependabot-config
```

This will run a setup script, writing to `.dependabot/config.yml`. Existing
files will not be overwritten unless you specify the `--force` flag.

[travis-badge]: https://img.shields.io/travis/com/eliasnorrby/dependabot-config?style=for-the-badge
[travis-link]: https://travis-ci.com/eliasnorrby/dependabot-config
[npm-badge]: https://img.shields.io/npm/v/@eliasnorrby/dependabot-config?style=for-the-badge
[npm-link]: https://www.npmjs.com/package/@eliasnorrby/dependabot-config
[dependabot-badge]: https://api.dependabot.com/badges/status?host=github&repo=eliasnorrby/dependabot-config
[dependabot-link]: https://dependabot.com
[semantic-release-badge]: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
[semantic-release-link]: https://github.com/semantic-release/semantic-release
