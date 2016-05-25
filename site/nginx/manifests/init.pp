class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
    subscribe => File['/etc/nginx/conf.d/default.conf'],
  }
  
  file { '/var/www':
      ensure => directory,
      owner => 'root',
      group => 'root',
      mode => '0755',
  }
  
  file { '/etc/nginx/nginx.conf':
        owner => 'root',
        group => 'root',
        mode => '0644',
        source => 'puppet:///modules/nginx/nginx.conf',
        require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d':
        ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
        owner => 'root',
        group => 'root',
        mode => '0644',
        source => 'puppet:///modules/nginx/default.conf',
        require => Package['nginx'],
  }
  
  file { '/var/www/index.html':
        owner => 'root',
        group => 'root',
        mode => '0644',
        source => 'puppet:///modules/nginx/index.html',
  }
}
