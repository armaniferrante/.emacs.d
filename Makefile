.PHONY: install-cpp

install-cpp:
	sudo apt-get install libclang-dev
	git clone --recursive https://github.com/Andersbakken/rtags.git
	cd rtags && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . && make
