LIBNAME = stdlib

PACKAGE_NAME = $(LIBNAME).zip

./build: 
	mkdir build
	
configure: ./build wally.toml src/*
	cp -rf src/* build/
	mv -f build/$(LIBNAME).lua build/init.lua
	cp -f wally.toml build/

package: configure
	wally package --output $(PACKAGE_NAME) --project-path build

publish: configure
	wally publish

clean: 
	rm -rf build $(PACKAGE_NAME)
