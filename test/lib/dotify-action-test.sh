#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/dotify-action.sh"

#
# dotify-action() tests
#

# Set required option ENV
DOTIFY_OPT_DEFAULT_ACTION="link"

# Simple mock for link action.
dotify-action-link() {
  echo "link stub: $@"
}


# Given a specific action.
assert "dotify-action link ackrc .ackrc" "link stub: ackrc .ackrc"

# Given "default" action, it uses configured default action.
assert "dotify-action default ackrc .ackrc" "link stub: ackrc .ackrc"

# Given a invalid action.
assert_raises "dotify-action foo ackrc .ackrc" 1
assert "dotify-action foo ackrc .ackrc" ""
assert "dotify-action foo ackrc .ackrc 2>&1" "ERROR: \"foo\" is not a valid action."

assert_end "dotify-action()"
