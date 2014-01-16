# requires vcsrepo module
# puppet module install puppetlabs/vcsrepo

# NTS
#  * clone to modulepath 	# puppet apply --configprint modulepath
#  * run / apply config	    # sudo puppet apply -e "include casperjs" --debug
class casperjs($version = "1.0.0" ) {

    $filename = "casperjs-${version}"
    $casper_bin_path = "/opt/${filename}/"

    vcsrepo { "$casper_bin_path" :
        ensure		=> 'present',
        provider	=> git,
        source		=> 'git://github.com/n1k0/casperjs.git',
        revision	=> $version,
    }

    file { "/usr/local/bin/casperjs" :
        target	=> "${casper_bin_path}/bin/casperjs",
        ensure 	=> link,
        require	=> Vcsrepo["$casper_bin_path"],
    }

}
