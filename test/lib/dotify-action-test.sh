#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/dotify-action.sh"

#
# dotify-action() tests
#

# Set required environment variables.
DOTIFY_RUN_MODE="install"
DOTIFY_OPT_DEFAULT_ACTION="link"

# Simple mock for link action.
dotify-action-link() {
  echo "link stub: $@"
}


# Given a specific action.
assert "dotify-action link ackrc .ackrc" "link stub: install .ackrc ackrc"

# Given a specific action without a <source>.
assert "dotify-action link .ackrc" "link stub: install .ackrc"

# Given "default" action, it uses configured default action.
assert "dotify-action default ackrc .ackrc" "link stub: install .ackrc ackrc"

# Given "default" action without a <source>, it uses configured default
# action.
assert "dotify-action default .ackrc" "link stub: install .ackrc"

# Given a invalid action.
assert_raises "dotify-action foo ackrc .ackrc" 1
assert "dotify-action foo ackrc .ackrc" ""
assert "dotify-action foo ackrc .ackrc 2>&1" "ERROR: \"foo\" is not a valid action."

assert_end "dotify-action()"
