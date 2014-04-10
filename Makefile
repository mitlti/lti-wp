deps:
	mkdir -p deps

deps/libxml2-2.9.1.tar.gz: | deps
	cd deps && wget https://git.gnome.org/browse/libxml2/snapshot/libxml2-2.9.1.tar.gz

deps/libxml2-2.9.1: | deps/libxml2-2.9.1.tar.gz
	cd deps && tar -xzf libxml2-2.9.1.tar.gz

libxml-install: | deps/libxml2-2.9.1
	cd deps/libxml2-2.9.1 && ./autogen.sh
	cd deps/libxml2-2.9.1 && ./configure --prefix=$$PWD/.. --with-python=no
	cd deps/libxml2-2.9.1 && make
	cd deps/libxml2-2.9.1 && make install

deps/php-5.5.11.tar.gz: | deps
	cd deps && wget http://www.php.net/distributions/php-5.5.11.tar.gz

deps/php-5.5.11: | deps/php-5.5.11.tar.gz
	cd deps && tar -xzf php-5.5.11.tar.gz

php-install: | deps/php-5.5.11
	cd deps/php-5.5.11 && ./configure --prefix=$$PWD/.. --with-libxml-dir=$$PWD/..
	cd deps/php-5.5.11 && make
	cd deps/php-5.5.11 && make install

fcgi-install:
	python gen_htaccess_fcgi.py
