#Increase traffic

# Increase the ULIMIT for Nginx
exec { 'increase_ulimit':
  command => 'sed -i "s/^ULIMIT=.*/ULIMIT=4096/" /etc/default/nginx',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "ULIMIT=4096" /etc/default/nginx',
}

# Increase worker connections in Nginx configuration
exec { 'increase_worker_connections':
  command => 'sed -i "s/worker_connections [0-9]*/worker_connections 1024/" /etc/nginx/nginx.conf',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "worker_connections 1024;" /etc/nginx/nginx.conf',
}

# Increase worker_rlimit_nofile in Nginx configuration
exec { 'increase_worker_rlimit_nofile':
  command => 'sed -i "s/worker_rlimit_nofile [0-9]*/worker_rlimit_nofile 4096/" /etc/nginx/nginx.conf',
  path    => ['/usr/bin', '/bin', '/usr/local/bin'],
  unless  => 'grep -q "worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf',
}

# Restart Nginx to apply changes
exec { 'nginx-restart':
  command     => '/etc/init.d/nginx restart',
  path        => ['/etc/init.d', '/usr/bin', '/bin'],
  subscribe   => [Exec['increase_ulimit'], Exec['increase_worker_connections'], Exec['increase_worker_rlimit_nofile']],
  refreshonly => true,
}

# Ensure order of execution
Exec['increase_ulimit'] ~> Exec['increase_worker_connections'] ~> Exec['increase_worker_rlimit_nofile'] ~> Exec['nginx-restart']
