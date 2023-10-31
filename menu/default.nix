{ writeShellApplication, neovim, kitty }:

writeShellApplication {
  name = "main-menu";

  runtimeInputs = [ neovim kitty ];

  text = builtins.readFile ./main.sh;
}
