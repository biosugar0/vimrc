.PHONY: install
install:
	@cp .vimrc ~/.vimrc
	@ls ~/.vimrc
	@cp -r .vim ~/
	@ls ~/
	vim -c :PackInstall
test:
	vim -c :q
