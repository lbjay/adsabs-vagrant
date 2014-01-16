#
# Standalone manifest - for dev Vagrant box.
#

import 'lib/*.pp'

include python
include setuptools
include fabric
include git
include mongodb
include vagrant
include phantomjs
include casperjs

#include gunicorn
#include nginx

#nginx::site { 'gunicorn':
#  config => 'gunicorn',
#}
