if test -e ~/dotfiles/my-kanata/kanata.kbd
  source $__fish_config_dir/kanata.fish
end

source $__fish_config_dir/android.fish
source $__fish_config_dir/esp.fish
source $__fish_config_dir/git.fish
source $__fish_config_dir/nvim.fish
# source $__fish_config_dir/tmux.fish



if status is-interactive
  set -gx TERM ghostty
  fish_add_path ~/.local/share/nvim/mason/packages/wgsl-analyzer/
  fish_add_path ~/.local/bin/
  fzf_key_bindings
  alias tree 'tree -I "target/"'
  export SHELL="/bin/fish"
end
