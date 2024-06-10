if status is-interactive 
and not set -q TMUX
  tmux -2 new-session -A -s main
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
end

if status is-interactive
  fish_add_path /opt/nvim/
  fish_add_path ~/.local/bin/
  fish_add_path ~/Shellscript/
  fzf_key_bindings
  fish_vi_key_bindings
  nohup kanata --cfg ~/dotfiles/kanata.kbd &
end
