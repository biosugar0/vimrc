.PHONY: install
install: /usr/local/bin/bat
	echo install
	@echo [Vim Setting] install vim settings...
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
	@echo [Vim Setting] install completed.

/usr/local/Homebrew/bin/brew:
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	
/usr/local/bin/bat:
	@make /usr/local/Homebrew/bin/brew
	@brew install bat

.PHONY: test
test:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
.PHONY: clean
clean:
	@rm -rf ~/.vim
	@rm -rf ~/.vimrc
