#!/bin/sh

# Remove default plugins
if [ -d /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/ ]; then
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/gzip.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/health.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/man.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/man.lua
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/matchit.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/matchparen.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/netrwPlugin.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/netrwPlugin.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/shada.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/spellfile.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tarPlugin.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tohtml.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tutor.vim
	rm /usr/local/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/zipPlugin.vim
fi

# if M1 Mac, /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/
if [ -d /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/ ]; then
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/gzip.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/health.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/man.lua
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/matchit.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/matchparen.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/netrwPlugin.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/shada.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/spellfile.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tarPlugin.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tohtml.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/tutor.vim
	rm /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/plugin/zipPlugin.vim
fi
