if status is-interactive 
and not set -q TMUX
  nohup kanata --cfg ~/dotfiles/kanata.kbd &
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
  alias vi "nvim"
  alias tree 'tree -I "target/"'
  export SHELL="/bin/fish"

  # for esp dev with rust
  fish_add_path /home/arne/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin
  export LIBCLANG_PATH="/home/arne/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"
end
