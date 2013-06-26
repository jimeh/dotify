#! /usr/bin/env bash
source "../assert.sh"

source "../../src/lib/trim.sh"

assert 'trim "  foo bar  "' "foo bar"
assert_end "trim()"
