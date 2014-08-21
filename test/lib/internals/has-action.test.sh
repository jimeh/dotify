#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/register-action.sh"
source "../../../src/lib/internals/has-action.sh"

#
# dotify-register-action() tests
#

# When no actions are registered.
assert_raises 'dotify-has-action "link"' 1

# When checking an action that is registered.
dotify-register-action "link"
assert_raises 'dotify-has-action "link"' 0
unset DOTIFY_ACTIONS

# When checking an action that is not registered.
dotify-register-action "link"
assert_raises 'dotify-has-action "git"' 1
unset DOTIFY_ACTIONS

# When registering and checking multiple actions
dotify-register-action "link"
dotify-register-action "git"
assert_raises 'dotify-has-action "link"' 0
assert_raises 'dotify-has-action "git"' 0
assert_raises 'dotify-has-action "copy"' 1
unset DOTIFY_ACTIONS


assert_end "dotify-register-action() tests"
