class nginx {
  package { 'nginx':
    ensure => present,
  }
  File {
    owner =>'root',
    group => 'root',
    mode => '0644',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf']],
  }
  
  file { '/var/www':
      ensure => directory,
      mode => '0755',
  }
  
  file { '/etc/nginx/nginx.conf':
        source => 'puppet:///modules/nginx/nginx.conf',
        require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d':
        ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
        source => 'puppet:///modules/nginx/default.conf',
        require => Package['nginx'],
  }
  
  file { '/var/www/index.html':
        source => 'puppet:///modules/nginx/index.html',
  }
}
