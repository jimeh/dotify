#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/dotfile-commands/default_action.sh"

#
# root_link() tests
#

# Sets DOTIFY_OPT_DEFAULT_ACTION
default_action foo
assert 'echo $DOTIFY_OPT_DEFAULT_ACTION' 'foo'
default_action foo bar
assert 'echo $DOTIFY_OPT_DEFAULT_ACTION' 'foo bar'
assert_end "root_link()"
