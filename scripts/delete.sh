if [[ $DELETE_WITH_BACKUPS = true ]]; then
    rm -rf ~/.config/nvim{,.bak}
    rm -rf ~/.local/share/nvim{,.bak}
    rm -rf ~/.local/state/nvim{,.bak}
    rm -rf ~/.cache/nvim{,.bak}
    echo "Delete along with backups was successful"
else
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    echo "Delete was successful"
fi
