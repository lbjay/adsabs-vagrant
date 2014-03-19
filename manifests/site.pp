#Puppet manifest for ads appservers

#Set global path for exec calls
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin" ] }

stage {'first':
  before  => Stage['main'],
}

stage {'last':
  require  => Stage['main'],
}


class {
  'stage_1': stage  => first;
  'stage_2': stage  => last;
}

class stage_2 {

  exec { 'provision': #Can't call newly bootstrapped modules from within the same puppet process!
    command     => 'puppet apply /vagrant/manifests/stage2.pp',
    timeout     => 0;
  }

}

class stage_1 {

  user {'vagrant':
    ensure      => present,
  }

  file {"/proj/":
    ensure      => directory,
    recurse     => false,
    owner       => vagrant,
    group       => vagrant,
    require     => User['vagrant'],
  }


  file {"/proj/ads/":
    ensure      => directory,
    recurse     => false,
    owner       => vagrant,
    group       => vagrant,
    require     => File["/proj/"]; #Alternatvively, use `exec {'mkdir -p /path/to/foo/': }`
  }

  exec { 'initial_apt_update':
    command   => 'apt-get update && touch /etc/apt-updated-by-puppet',
    creates   => '/etc/apt-updated-by-puppet',
  }  

  package { ['rubygems','ruby-dev','puppet','git',
              'nginx','python-pip','libmysqlclient-dev',
              'python-dev','build-essential','libxml2-dev','libxslt-dev','mongodb']:
    ensure    => installed,
    require   => Exec['initial_apt_update'];
  }

  package { ['ipython','mtr','locate','nano','host','psmisc']: #Convenience packages, not mission critical
    ensure     => installed,
    require    => Exec['initial_apt_update'];
  }

  package { 'librarian_puppet':
    name      => 'librarian-puppet',
    ensure    => installed,
    provider  => gem,
    require   => Package['rubygems']
  }

  #We will install modules to /etc/puppet due to inconvience of vagrant-lxc user permission problems
  file {'/etc/puppet/Puppetfile':
    ensure    => link,
    target    => '/vagrant/Puppetfile';
  }

  exec { 'librarian_puppet_install':
    command   => 'librarian-puppet install',
    cwd       => '/etc/puppet',
    environment => 'HOME=/root', #Must be specified or librarian-puppet will break
    user      => root,
    require   => [Package['librarian_puppet'],File['/etc/puppet/Puppetfile']];
  }

  exec {'bootstrap_pip':
    command   => 'pip install pip --upgrade',
    require   => [Package['python-pip'],Package['git'],Package['libmysqlclient-dev'],
                  Package['python-dev'],Package['build-essential'],Package['libxslt-dev'],
                  Package['libxml2-dev']];
  }

  package {['gunicorn','fabric']: 
    provider  => pip,
    ensure    => installed,
    require   => Exec['bootstrap_pip'];
  }
}
