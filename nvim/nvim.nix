{ config, pkgs, ... }:


{
    #home.packages = [ pkgs.neovim ];
    programs.neovim =
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      in
      {
        enable = true;
#        extraConfig = ''
#          set number relativenumber
#          lua << EOF
#          ${builtins.readFile ./plugin/mappings.lua}
#        '';
        
	plugins = with pkgs.vimPlugins; [
          
          # tree
            nerdtree

          # lualine
            # nvim-web-devicons
            vim-devicons
            lualine-nvim
            {
              plugin = lualine-nvim;
              config = toLuaFile ./plugin/other.lua;
              #config = toLuaFile ./plugin/lsp.lua;
            }

          # Comment
            {
              plugin = comment-nvim;
              config = toLua "require(\"Comment\").setup()";
            }

          # Telescope
            plenary-nvim
            {
              plugin = telescope-nvim;
             # config = toLuaFile ./plugin/telescope.lua;
            }

          # Theme
            {
               plugin = nightfox-nvim; # oxocarbon onedarkpro tokyonight rose-pine
               config = "colorscheme carbonfox"; # oxocarbon onedark_dark tokyonight-night rose-pine
            }
          
          # Languages
          lsp-zero-nvim
          nvim-lspconfig
          rust-tools-nvim
          vim-nix
          vim-prisma
          vim-terraform
          
          # Completions
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp-treesitter
          cmp_luasnip
          copilot-cmp
          copilot-lua
          friendly-snippets
          lspkind-nvim
          luasnip
          nvim-cmp

          coc-nvim
          toggleterm-nvim
          # Others
            #{
            #  plugin = nvim-tree;
            #  config = toLua "require(\"Comment\").setup()";
            #}

            #nvim-cmp 
            #{
            #  plugin = nvim-cmp;
            #  config = toLuaFile ./plugin/cmp.lua;
            #}

            #telescope-fzf-native-nvim
            #cmp_luasnip
            #luasnip
            #{
            #  plugin = (nvim-treesitter.withPlugins (p: [
            #    p.tree-sitter-nix
            #    p.tree-sitter-vim
            #    p.tree-sitter-bash
            #    p.tree-sitter-lua
            #    p.tree-sitter-python
            #    p.tree-sitter-json
            #  ]));
            #  config = toLuaFile ./plugin/treesitter.lua;
            #}
            #nvim-compe
            #galaxyline-nvim
            #indentLine
            #nvim-bufferline-lua
            #nvim-toggleterm-lua
            #vim-closetag
            #pears-nvim
            # {
            #   plugin = pkgs.vimPlugins.vim-startify;
            #   config = "let g:startify_change_to_vcs_root = 0";
            # }
            # 
            #nvim-colorizer-lua
            #nvim-treesitter
            #vim-nix
            #friendly-snippets
            #neodev-nvim
            #{
            #  plugin = nvim-lspconfig;
            #  config = toLuaFile ./plugin/lsp.lua;
            #}
	];
    };

}
