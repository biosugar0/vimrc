.PHONY: install
brew:
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
install:
	@echo [Vim Setting] install vim settings...
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
	@brew install bat
	@echo [Vim Setting] install completed.
test:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
clean:
	@rm -rf ~/.vim
	@rm -rf ~/.vimrc
