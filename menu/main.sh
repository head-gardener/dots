#!/bin/sh

TERM_EMUL="$(which kitty)"

case $(echo -ne '⚡  run\n  configure\n  math\n☎ news' | dmenu) in
  *configure)
    path="$(find "$HOME"/dots/ -maxdepth 1 -mindepth 1\
      -type d -not -name '\.*' -printf '%P\n' | dmenu)"

    # TODO: use $EDITOR
    test -n "$path" && path="$HOME/dots/$path" \
      && test -e "$path" && "$TERM_EMUL" nvim "$path"
    ;;

  *run)
    i3-dmenu-desktop
    ;;

  *math)
    hist="/tmp/menu-math-hist"
    echo -n '' >> "$hist"
    while\
      expr="$(dmenu < "$hist")" && [ -n "$expr" ]
    do
      echo -e "$(julia -E "using LinearAlgebra; $expr")\n$expr"\
        | cat - "$hist" > "$hist)t"
      head -40 "$hist)t" > "$hist"
    done
    ;;

  *news)
    kitty --class newsboat newsboat
    ;;
esac
