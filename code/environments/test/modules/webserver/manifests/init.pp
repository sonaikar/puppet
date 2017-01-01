#/etc/puppet/modules/webserver/manifests/init.pp
class webserver {
    package { 'httpd':
        ensure => installed,
    }
    file { 'www1.conf':
        path => '/etc/httpd/conf.d/www1.conf',
        ensure => file,
        require => [Package['httpd'], File['www1.index']],
        source => "puppet:///modules/webserver/www1.conf",
    }
    file { 'www1.index':
        path => '/var/www/index.html',
        ensure => file,
        source => "puppet:///modules/webserver/index1.html",
        require => Package['httpd'],
    }
    file { 'www2.index':
        path => '/var/www2/index.html',
        ensure => file,
        require => File['www2.docroot'],
        source => "puppet:///modules/webserver/index2.html",
        #seltype => 'httpd_sys_content_t',
    }
    file { 'www2.conf':
        path => '/etc/httpd/conf.d/www2.conf',
        ensure => file,
        require => [Package['httpd'], File['www2.index']],
        source => "puppet:///modules/webserver/www2.conf",
    }
    file { 'www2.docroot':
        path => '/var/www2',
        ensure => directory,
        #seltype => 'httpd_sys_content_t',
    }
    service { 'httpd':
        name => 'httpd',
        ensure => running,
        enable => true,
        subscribe => [File['www1.conf'], File['www2.conf']],
    }
  #  service { 'iptables':
  #      name => 'iptables',
  #      ensure => running,
  #      enable => true,
  #      subscribe => File['iptables.conf'],
  #  }
  #  file { 'iptables.conf':
  #      path => '/etc/sysconfig/iptables',
  #      ensure => file,
  #      source => "puppet:///modules/webserver/iptables.conf",
  #  }
 
}
