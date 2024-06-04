#Replace pphp with php

$file = '/var/www/html/wp-settings.php'

exec { 'replace_line':
  command => "sed -i '/phpp/ s/phpp/php/g' ${file}",
  path    => ['/bin/', 'usr/bin']
}
