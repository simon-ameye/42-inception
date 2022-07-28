#!/bin/sh

# wait for mysql
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
	sleep 1
done

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then

	#wordpress config available at /sameye.42.fr/wordpress
	#or /sameye.42.fr/wordpress/wp-login.php
	wp core download --allow-root

	wp config create \
		--dbname=$WP_DATABASE_NAME \
		--dbuser=$WP_DATABASE_USR \
		--dbpass=$WP_DATABASE_PWD \
		--dbhost=$MYSQL_HOST \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--allow-root

	wp core install\
		--url=$DOMAIN_NAME\
		--title=$WP_TITLE\
		--admin_user=$WP_ADMIN_USR\
		--admin_password=$WP_ADMIN_PWD\
		--admin_email=$WP_ADMIN_EMAIL\
		--skip-email\
		--allow-root

	wp user create $WP_USR $WP_EMAIL\
		--role=author\
		--user_pass=$WP_PWD\
		--allow-root

	wp theme install twentytwenty --activate --allow-root
	wp plugin update --all --allow-root

fi

echo "Done!"
/usr/sbin/php-fpm7 -F -R