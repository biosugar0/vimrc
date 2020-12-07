.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@cp -r .vim ~/
	@vim -c :q
