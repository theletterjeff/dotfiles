#!/bin/bash

# clone or update nvchad repo
if [ -d "$HOME/.config/nvim" ]; then
    pushd "$HOME/.config/nvim" && git pull origin && popd
else
    git clone https://github.com/NvChad/NvChad "$HOME/.config/nvim" --depth 1 && nvim
fi

# add symlink to nvchad_custom
if [ ! -L "$HOME/.config/nvim/lua/custom" ]; then
    ln -s "$HOME/.nvchad_custom" "$HOME/.config/nvim/lua/custom"
fi
