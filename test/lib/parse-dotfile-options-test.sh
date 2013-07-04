#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/parse-dotfile-options.sh"
source "../../src/lib/trim.sh"

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
restore "parse-dotfile-default_action-option"


assert_end "parse-dotfile-options()"


#
# parse-dotfile-option()
#

# Create temp files/folders used for locate-dotfile() tests.
mkdir -p "test-tmp/with" "test-tmp/without"
echo -e "foo_bar .things\nlink: foo -> .foo" > "test-tmp/with/Dotfile"
echo -e "link: foo -> .foo" > "test-tmp/without/Dotfile"

# When $DOTFILE contains root_link option.
DOTFILE="test-tmp/with/Dotfile"
assert 'parse-dotfile-option foo_bar .none' ".things"
unset DOTFILE

# When $DOTFILE does not contain root_link option.
DOTFILE="test-tmp/without/Dotfile"
assert 'parse-dotfile-option foo_bar .none' ".none"
unset DOTFILE

# When Dotfile to parse is specified as argument.
assert 'parse-dotfile-option foo_bar .none test-tmp/with/Dotfile' ".things"
assert 'parse-dotfile-option foo_bar .none test-tmp/without/Dotfile' ".none"

# When option is wrapped across multiple lines with a backslash.
echo 'foo_bar \'         > "test-tmp/with/Dotfile"
echo '  .things'        >> "test-tmp/with/Dotfile"
echo 'link: foo -> bar' >> "test-tmp/with/Dotfile"
DOTFILE="test-tmp/with/Dotfile"
assert 'parse-dotfile-option foo_bar .none' ".things"
unset DOTFILE

# Remove temp files/folders used for locate-dotfile() tests.
rm "test-tmp/with/Dotfile" "test-tmp/without/Dotfile"
rmdir "test-tmp/with" "test-tmp/without" "test-tmp"

assert_end "parse-dotfile-option()"


#
# parse-dotfile-root_link-option()
#

stub "parse-dotfile-option"
assert 'parse-dotfile-root_link-option' \
  'parse-dotfile-option stub: root_link .dotfiles '
assert 'parse-dotfile-root_link-option "test-tmp/with/Dotfile"' \
  'parse-dotfile-option stub: root_link .dotfiles test-tmp/with/Dotfile'
restore "parse-dotfile-option"

assert_end "parse-dotfile-root_link-option()"


#
# parse-dotfile-default_action-option()
#

stub "parse-dotfile-option"
assert 'parse-dotfile-default_action-option' \
  'parse-dotfile-option stub: default_action link '
assert 'parse-dotfile-default_action-option "test-tmp/with/Dotfile"' \
  'parse-dotfile-option stub: default_action link test-tmp/with/Dotfile'
restore "parse-dotfile-option"

assert_end "parse-dotfile-default_action-option()"
