exec { 'increase_worker_connections':
  command => 'sed -i "s/worker_connections .*/worker_connections 1000;/" /etc/nginx/nginx.conf',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "worker_connections 1000;" /etc/nginx/nginx.conf',
}

exec { 'increase_worker_rlimit_nofile':
  command => 'sed -i "s/worker_rlimit_nofile .*/worker_rlimit_nofile 4096;/" /etc/nginx/nginx.conf',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf',
}

exec { 'nginx-restart':
  command     => '/etc/init.d/nginx restart',
  path        => ['/etc/init.d', '/usr/bin'],
  subscribe   => Exec['increase_worker_connections', 'increase_worker_rlimit_nofile'],
  refreshonly => true,
}

Exec['increase_worker_connections'] ~> Exec['increase_worker_rlimit_nofile'] ~> Exec['nginx-restart']
