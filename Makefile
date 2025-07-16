LIBNAME = stdlib

PACKAGE_NAME = $(LIBNAME).zip

CP = cp -rf
MV = mv -f
RM = rm -rf

SOURCES =	src/algorithm.luau	\
        	src/Events.luau	\
			src/stack.luau	\
			src/mutex.luau	\
			src/utility.luau	\
			src/vector.luau	\
			src/Part.luau	\
			src/math.luau	\
			src/types.luau	\
			src/init.luau

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

tests.rbxl: ./DevPackages $(LIBNAME).project.json $(SOURCES)
	rojo build $(LIBNAME).project.json --output $@

tests: clean-tests tests.rbxl

sourcemap.json: ./DevPackages $(LIBNAME).project.json
	rojo sourcemap $(LIBNAME).project.json --output $@

# Re gen sourcemap
sourcemap: clean-sourcemap sourcemap.json


clean-sourcemap: 
	$(RM) sourcemap.json

clean-rbxm:
	$(RM) $(RBXM_BUILD)

clean-tests:
	$(RM) tests.rbxl

clean-build:
	$(RM) $(BUILD_DIR)

clean: clean-tests clean-build clean-rbxm
	$(RM) $(PACKAGE_NAME) 