class setuptools {
  package { ['setuptools']:
    provider => 'pip',
    ensure   => 'latest',
    install_options => ['--no-use-wheel'],
  }
}