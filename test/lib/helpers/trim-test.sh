#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/trim.sh"

assert 'trim "  foo bar  "' "foo bar"
assert 'trim "foo bar  "' "foo bar"
assert 'trim "  foo bar"' "foo bar"
assert 'trim "foo bar"' "foo bar"
assert_end "trim()"
