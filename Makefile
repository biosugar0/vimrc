.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
	@vim -c ":normal 1 ee"
test:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@yes | vim -c :qa
clean:
	@rm -rf ~/.vim
	@rm -rf ~/.vimrc
