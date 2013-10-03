#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/helpers/trim.sh"

#
# trim() tests
#

assert 'trim "  foo bar  "' "foo bar"
assert 'trim "foo bar  "' "foo bar"
assert 'trim "  foo bar"' "foo bar"
assert 'trim "foo bar"' "foo bar"
assert_end "trim()"
