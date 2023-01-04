#!/usr/bin/env bash

set -e

yarn build
git subtree push --prefix dist origin gh-pages
