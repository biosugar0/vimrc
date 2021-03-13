.PHONY: install
install:
	@echo [Vim Setting] install vim settings...
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
	@echo [Vim Setting] install completed.
test:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
clean:
	@rm -rf ~/.vim
	@rm -rf ~/.vimrc
