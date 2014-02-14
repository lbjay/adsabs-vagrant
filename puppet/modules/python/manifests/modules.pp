class python::modules {
  package { [ 
        'libmysqlclient-dev',
        'libxml2-dev',
        'python-libxml2',
        'libxslt-dev',
        'gettext',
        'netpbm',
        'pstotext',
        'giflib-tools',
        'html2text',
        'pdftk',
        'gs-common',
        'gnuplot',
        'apache2-mpm-prefork',
        'mysql-server',
        'poppler-utils',
        'clisp',
        'libapache2-mod-wsgi',
        'unzip',
        'automake',
        'python-dev', 
        'python-pip',
        ]:
        ensure => 'installed';
    }
    package {
        'virtualenv':
            provider=>pip,
            ensure=>"1.11.2";
    }
}

