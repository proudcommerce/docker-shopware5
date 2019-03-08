#!/usr/bin/env bash
set -e

echo "##### starting containers #####"
docker-compose up -d

if [ ! -f ./web/www/shopware.php ]
then
	echo "##### install shopware #####"
	git clone https://github.com/shopware/composer-project.git web/www/
	docker-compose exec shopware5_web composer install --no-scripts
	cp files/shopware.env web/www/.env
	docker-compose exec shopware5_web app/bin/install.sh
fi
