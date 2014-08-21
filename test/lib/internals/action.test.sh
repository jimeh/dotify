#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/action.sh"

#
# dotify-action() tests
#

stub "dotify-setup-root-link"
stub_and_echo "dotify-get-run-mode" "install"
stub_and_echo "dotify-get-default-action" "link"
stub_and_echo "dotify-action-link" "link stub: \$@"

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


restore "dotify-setup-root-link"
restore "dotify-get-run-mode"
restore "dotify-action-link"
assert_end "dotify-action()"
