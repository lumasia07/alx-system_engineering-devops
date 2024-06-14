#Increase traffic

exec { 'increase_ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "4096" /etc/default/nginx',
}

exec { 'nginx-restart':
  command     => '/etc/init.d/nginx restart',
  path        => ['/etc/init.d', '/usr/bin', '/bin'],
  subscribe   => Exec['increase_ulimit'],
  refreshonly => true,
}

Exec['increase_ulimit'] -> Exec['nginx-restart']
