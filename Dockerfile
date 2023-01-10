FROM ubuntu:latest
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get -y install apache2
RUN apt-get -y install apache2-utils mariadb-server mariadb-client
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get -y install php7.4
RUN apt-get clean
RUN apt-get install wget -y
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz
RUN tar -xzvf wordpress-6.1.1.tar.gz -C /var/www/
WORKDIR /var/www
RUN cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
RUN sed -i 's/database_name_here/tutorial/' /var/www/wordpress/wp-config.php
RUN sed -i 's/username_here/login/' /var/www/wordpress/wp-config.php
RUN sed -i 's/password_here/login/' /var/www/wordpress/wp-config.php
RUN sed -i 's/localhost/20.246.118.148/' /var/www/wordpress/wp-config.php
COPY . /var/www/wordpress
RUN ls wordpress/
WORKDIR /etc/apache2/sites-enabled
RUN sed -i 's/\/var\/www\/html/\/var\/www\/wordpress/' /etc/apache2/sites-enabled/000-default.conf 
EXPOSE 80 
CMD ["apache2ctl", "-D","FOREGROUND"]
