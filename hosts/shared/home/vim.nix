{ pkgs, ... } :

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
	  nerdtree 
  	  nerdtree-git-plugin 
	  auto-pairs 
	  vim-airline 
	  fzf-vim 
	  vim-floaterm
      papercolor-theme
      coc-nvim
      dracula-vim
      rust-vim
      markid
      vim-svelte
      vim-javascript
      yats-vim
    ];
    extraConfig = ''source /etc/nixos/config/vim/addall.vim'';
  };
}
