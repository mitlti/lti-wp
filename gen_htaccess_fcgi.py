import sys
import os
import string

cwd = os.path.dirname(os.path.realpath(__file__))

htaccess = """AddHandler fcgid-script .php
Options +ExecCGI
FcgidWrapper CWD/php.fcgi .php

# Customize the next two directives for your requirements.
Order allow,deny
Allow from all
"""

fcgi = """#!/bin/sh
PHP_FCGI_CHILDREN=4
export PHP_FCGI_CHILDREN
exec CWD/deps/bin/php-cgi
"""

htaccess = string.replace(htaccess, 'CWD', cwd)
fcgi = string.replace(fcgi, 'CWD', cwd)

h = open('.htaccess', 'w')
h.write(htaccess)
h.close()

f = open('php.fcgi', 'w')
f.write(fcgi)
f.close()
