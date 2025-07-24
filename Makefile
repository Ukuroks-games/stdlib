LIBNAME = stdlib

PACKAGE_NAME = $(LIBNAME).zip

RBXM_BUILD = $(LIBNAME).rbxm

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
			src/queue.luau	\
			src/math.luau	\
			src/types.luau	\
			src/init.luau

TESTS_POSTFIX = server.luau

TESTS_SOURCES =	tests/test.$(TESTS_POSTFIX)	\
				tests/algorithm/Find/init.$(TESTS_POSTFIX)	\
				tests/algorithm/is_sorted/init.$(TESTS_POSTFIX)	\
				tests/algorithm/max_element/init.$(TESTS_POSTFIX)	\
				tests/algorithm/max_key/init.$(TESTS_POSTFIX)	\
				tests/algorithm/min_element/init.$(TESTS_POSTFIX)	\
				tests/algorithm/min_key/init.$(TESTS_POSTFIX)	\
				tests/algorithm/testReverse/init.$(TESTS_POSTFIX)	\
				tests/algorithm/testSort/init.$(TESTS_POSTFIX)	\
				tests/algorithm/search.$(TESTS_POSTFIX)	\
				tests/math/factorial.$(TESTS_POSTFIX)	\
				tests/math/integral.$(TESTS_POSTFIX)	\
				tests/mutex/mutexTest.$(TESTS_POSTFIX)	\
				tests/queue/testQueue/init.$(TESTS_POSTFIX)	\
				tests/utility/merge/init.$(TESTS_POSTFIX)

./build: 
	mkdir build
	
configure: ./build wally.toml $(SOURCES)
	$(CP) src/* build/
	$(CP) wally.toml build/

package: configure
	wally package --output $(PACKAGE_NAME) --project-path build

publish: configure
	wally publish --project-path build

lint:
	selene src/ tests/

./Packages: wally.toml
	wally install

./DevPackages: wally.toml
	wally install

$(RBXM_BUILD): library.project.json $(SOURCES)
	rojo build library.project.json --output $@

rbxm: clean-rbxm $(RBXM_BUILD)

tests.rbxl: ./Packages ./DevPackages $(LIBNAME).project.json $(SOURCES) $(TESTS_SOURCES)
	rojo build $(LIBNAME).project.json --output $@

tests: clean-tests tests.rbxl

sourcemap.json: ./Packages ./DevPackages $(LIBNAME).project.json
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