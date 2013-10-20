#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/dotfile-commands/root_link.sh"

#
# root_link() tests
#

# Sets DOTIFY_OPT_ROOT_LINK
root_link .dots
assert 'echo $DOTIFY_OPT_ROOT_LINK' '.dots'
root_link my dots
assert 'echo $DOTIFY_OPT_ROOT_LINK' 'my dots'
assert_end "root_link()"
