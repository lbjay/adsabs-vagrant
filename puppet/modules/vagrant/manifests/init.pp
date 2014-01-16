class vagrant {
  line { 'line-venv-activate':
    ensure => present,
    file   => '/home/vagrant/.bashrc',
    line   => 'cd /vagrant && . dev/venv/bin/activate',
  }
  file { '/srv/www':
    ensure => link,
    target => '/vagrant',
  }
}