#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/register-action.sh"

#
# dotify-register-action() tests
#

# Registering an action.
dotify-register-action "link"
assert 'echo ${DOTIFY_ACTIONS[@]}' "link"
unset DOTIFY_ACTIONS

# Registering multiple actions.
dotify-register-action "link"
dotify-register-action "git"
assert 'echo ${DOTIFY_ACTIONS[@]}' "link git"
unset DOTIFY_ACTIONS

# Registering the same action multiple times.
dotify-register-action "link"
dotify-register-action "link"
assert 'echo ${DOTIFY_ACTIONS[@]}' "link"
assert_raises 'dotify-register-action "link"' 1
unset DOTIFY_ACTIONS


assert_end "dotify-register-action() tests"
