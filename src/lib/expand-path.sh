# Expands given path.
#
# Example:
#
#   $ expand-path "~/Projects"
#   /Users/jimeh/Projects
#   $ expand-path "config/*.json"
#   config/application.json config/database.yml
#
expand-path() {
  echo $(eval echo "$@")
}
