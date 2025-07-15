LIBNAME = stdlib

PACKAGE_NAME = $(LIBNAME).zip

CP = cp -rf
MV = mv -f
RM = rm -rf

./build: 
	mkdir build
	
configure: ./build wally.toml src/*
	$(CP) src/* build/
	$(CP) wally.toml build/

package: configure
	wally package --output $(PACKAGE_NAME) --project-path build

publish: configure
	wally publish --project-path build

lint:
	selene src/ tests/

./DevPackages: wally.toml
	wally install

$(LIBNAME).rbxm:
	rojo build library.project.json --output $@

tests: tests.rbxl

tests.rbxl: ./DevPackages
	rojo build $(LIBNAME).project.json --output $@

sourcemap.json: ./DevPackages
	rojo sourcemap $(LIBNAME).project.json --output $@

delete-sourcemap: 
	$(RM) sourcemap.json

# Re gen sourcemap
sourcemap: delete-sourcemap sourcemap.json

clean:
	$(RM) build $(PACKAGE_NAME) $(LIBNAME).rbxm