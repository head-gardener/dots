{ writeShellApplication, kitty, julia, neovim }:

writeShellApplication {
  name = "main-menu";

  runtimeInputs = [ kitty julia ];

  text = builtins.readFile ./main.sh;
}
