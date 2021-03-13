.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@ls ~/.vimrc
	@cp -r .vim ~/
	@ls ~/
	@yes | vim -c :qa
clean:
	@rm -rf ~/.vim
	@rm -rf ~/.vimrc
