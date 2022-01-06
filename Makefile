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
	
/usr/local/bin/bat:
	@make /usr/local/Homebrew/bin/brew
	@brew install bat

.PHONY: test
test:
	@cp -r .vim ~/
	@yes | vim -c :qa
.PHONY: clean
clean:
	@rm -rf ~/.vim
