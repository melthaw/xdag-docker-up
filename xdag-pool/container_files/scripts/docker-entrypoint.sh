#!/bin/bash

set +e

# Script trace mode
if [ "${DEBUG_MODE}" == "true" ]; then
    set -o xtrace
fi

# Default timezone for web interface
PHP_TZ=${PHP_TZ:-"Europe/Riga"}

echo "########################################################"

ls -al /etc/php/7.0/fpm
cat /etc/php/7.0/fpm/php-fpm.conf

service php7.0-fpm stop
echo "** Executing supervisord"
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

echo "########################################################"
