dotify-main() {
  dotify-main-parse-arguments $@
  dotify-main-parse-command $@
  dotify-main-dispatcher $@

  return $?
}
