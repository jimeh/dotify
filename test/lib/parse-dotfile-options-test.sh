#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/parse-dotfile-options.sh"

#
# parse-dotfile-options()
#

stub "parse-dotfile-root_link-option"
stub "parse-dotfile-default_action-option"

parse-dotfile-options
assert 'echo "$OPT_ROOT_LINK"' \
  "parse-dotfile-root_link-option stub: "
assert 'echo "$OPT_DEFAULT_ACTION"' \
  "parse-dotfile-default_action-option stub: "

restore "parse-dotfile-root_link-option"
restore "parse-dotfile-default_link-option"

assert_end "parse-dotfile-options()"
