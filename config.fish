if status is-interactive
# don't nest inside another tmux
and not set -q TMUX
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux -2 new-session -A -s main
end
if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_add_path /opt/nvim/
  fish_add_path ~/.local/bin/
  fish_add_path ~/Shellscript/
  fzf_key_bindings
  alias vi "nvim"
  alias tree 'tree -I "target/"'
end
