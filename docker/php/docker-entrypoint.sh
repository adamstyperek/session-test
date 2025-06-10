#!/bin/sh
set -e

#echo "Waiting for MySQL..."
#while ! nc -z mysql 3306; do
#    sleep 1
#done
#echo "MySQL is up - executing migrations"

#php bin/console doctrine:migrations:migrate --no-interaction

# Start Apache in foreground
exec apache2-foreground 