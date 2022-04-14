{ pkgs, config, lib, ... }:
with lib;
with builtins;

let
  cfg = config.vim.theme;
in
{

  options.vim.theme = {
    enable = mkOption {
      type = types.bool;
      description = "Enable Theme";
    };

    name = mkOption {
      type = types.enum [ "material" ];
      description = ''Name of theme to use: "material"'';
    };
    
    style = mkOption {
      type = types.enum [ "darker" ];
      description = ''Style of theme to use: "darker"'';
    };
  };

  config = mkIf cfg.enable
    (
      let
        mkVimBool = val: if val then "1" else "0";
      in
      {

        vim.configRC = ''
          let g:${cfg.name}_style = "${cfg.style}"
          colorscheme ${cfg.name}
        '';

        vim.startPlugins = with pkgs.neovimPlugins;
          [ material-nvim ];
      }
    );
}
