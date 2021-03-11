.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@ls ~/.vimrc
	@cp -r .vim ~/
	@ls ~/
	vim -c :qa
test:
	vim -c :q
