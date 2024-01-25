{
  outputs = { self, nixpkgs }: {

    nixosModules = {
      home = { inputs, ... }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.hunter = import ./home-manager/home.nix;
        home-manager.extraSpecialArgs = { inherit inputs; };
      };
    };

  };
}
