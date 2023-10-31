#!/bin/sh

# case $(echo -ne '⚡  run\n  configure\n  math' | dmenu) in
case $(echo -ne '⚡  run\n  configure' | dmenu) in
  *configure)
    path="$(find "$HOME"/dots/ -maxdepth 1 -mindepth 1\
      -type d -not -name '\.*' -printf '%P\n' | dmenu)"

    test -n "$path" && path="$HOME/dots/$path" \
      && test -e "$path" && kitty nvim "$path"
    ;;

  *run)
    i3-dmenu-desktop
    ;;
esac
