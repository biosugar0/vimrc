MAKEFILE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: install
install: /usr/local/bin/bat
	echo install
	@echo [Vim Setting] install vim settings...
	@cp -r .vim ~/
	@yes | vim -c :qa
	@echo [Vim Setting] install completed.

.PHONY: installn
installn: /usr/local/bin/bat
	echo install
	@echo [Vim Setting] install vim settings...
	@ln -s $(PWD)/.vim $(HOME)/.vim
	@yes | vim -c :qa
	@echo [Vim Setting] install completed.

/usr/local/Homebrew/bin/brew:
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	
/usr/local/bin/bat: /usr/local/Homebrew/bin/brew
	@brew install bat

/usr/local/bin/node: /usr/local/Homebrew/bin/brew
	@brew install bat

/usr/local/bin/python3: /usr/local/Homebrew/bin/brew
	@brew install python3

/usr/local/bin/nvim: /usr/local/Homebrew/bin/brew
	@brew install neovim

.PHONY: install-nvim
install-nvim: /usr/local/bin/nvim $(HOME)/.config/nvim/

$(HOME)/.config/nvim/: /usr/local/bin/bat /usr/local/bin/python3
	@echo [Neovim Setting] install neovim settings...
	@ln -s $(MAKEFILE_DIR)/nvim $(HOME)/.config/nvim 
	@echo [Neovim Setting] install completed.

.PHONY: test
test:
	@cp -r .vim ~/
	@yes | vim -c :qa
.PHONY: clean
clean:
	@rm -rf ~/.vim
