.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@ls ~/.vimrc
	@cp -r .vim ~/
	@ls ~/
	vim -c :q
test:
	vim -c :q
