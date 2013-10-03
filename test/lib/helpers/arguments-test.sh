#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/arguments.sh"


#
# has-argument() tests
#

# Returns 1 when it does not have argument.
assert_raises 'has-argument help h -v -f --debug' 1

# Returns 0 when any form of the argument is present.
assert_raises 'has-argument help h -v --help' 0
assert_raises 'has-argument help h -v --help=wtf' 0
assert_raises 'has-argument help h -v -h' 0
assert_raises 'has-argument help h -v -h=wtf' 0

assert_end "has-argument()"


#
# parse-argument() tests
#

# Echos nothing and returns 1 when argument is not present.
assert        'parse-argument file f -v --debug' ""
assert_raises 'parse-argument file f -v --debug' 1

# echos value of argument and returns 0 when any form of argument is present.
assert        'parse-argument file f -v --file foo/bar.txt' "foo/bar.txt"
assert_raises 'parse-argument file f -v --file foo/bar.txt' 0
assert        'parse-argument file f -v --file=foo/bar.txt' "foo/bar.txt"
assert_raises 'parse-argument file f -v --file=foo/bar.txt' 0
assert        'parse-argument file f -v -f foo/bar.txt' "foo/bar.txt"
assert_raises 'parse-argument file f -v -f foo/bar.txt' 0
assert        'parse-argument file f -v -f=foo/bar.txt' "foo/bar.txt"
assert_raises 'parse-argument file f -v -f=foo/bar.txt' 0

# Value with a space.
assert 'parse-argument file f -v --file foo\ bar.txt' "foo bar.txt"
assert 'parse-argument file f -v --file "foo bar.txt"' "foo bar.txt"
assert "parse-argument file f -v --file 'foo bar.txt'" "foo bar.txt"

assert 'parse-argument file f -v --file=foo\ bar.txt' "foo bar.txt"
assert 'parse-argument file f -v --file="foo bar.txt"' "foo bar.txt"
assert "parse-argument file f -v --file='foo bar.txt'" "foo bar.txt"


assert_end "parse-argument()"
