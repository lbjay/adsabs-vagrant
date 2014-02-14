class vagrant {
  file_line { 'line-venv-activate':
    ensure => present,
    path   => '/home/vagrant/.bashrc',
    line   => 'cd /vagrant && . venv/bin/activate',
  }
  file { '/srv/www':
    ensure => link,
    target => '/vagrant',
  }
}