class fabric {
  package { ['Fabric','Jinja2']:
    provider => 'pip',
    ensure   => 'present',
  }
}