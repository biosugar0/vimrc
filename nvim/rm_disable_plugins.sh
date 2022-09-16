#!/bin/sh

# Remove default plugins
if [ -d /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/ ]; then
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/gzip.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/health.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/man.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchit.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/matchparen.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/netrwPlugin.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/shada.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/spellfile.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tarPlugin.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tohtml.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/tutor.vim
    rm /usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/plugin/zipPlugin.vim
fi
