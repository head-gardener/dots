#!/bin/sh


case $(echo -ne '⚡ run\n⚓ configure' | dmenu) in
  *configure)
    path="$(ls $HOME/dots | dmenu)"

    test -n "$path" && path="$HOME/dots/$path" \
      && test -e "$path" && kitty nvim "$path"
    ;;

  *run)
    i3-dmenu-desktop
    ;;
esac
