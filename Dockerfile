FROM centos:7

# apache, php, mysql, etc
RUN yum -y update \
	&& yum -y install epel-release \
	&& rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
	&& rpm -ivh http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm \
	&& yum -y install httpd mysql-community-server \
	&& yum -y install --enablerepo=remi --enablerepo=remi-php56 \
		php php-devel php-mbstring php-mcrypt php-mysqlnd php-pecl-xdebug php-gd php-xml \
	&& yum -y install ssmtp git vim fish wget

# fish
WORKDIR /tmp
RUN wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz \
	&& tar xvzf peco_linux_amd64.tar.gz \
	&& mv peco_linux_amd64/peco /usr/local/bin/ \
	&& curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher \
	&& su -c "fisher oh-my-fish/plugin-peco" -s /bin/fish \
	&& su -c "fisher 0rax/fish-bd" -s /bin/fish \
	&& su -c "fisher install z" -s /bin/fish

# composer
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& composer self-update

RUN mkdir /bootstrap
COPY start.sh /bootstrap
RUN rm /etc/php.d/15-xdebug.ini

RUN chmod +x /bootstrap/start.sh
ENTRYPOINT ["/bootstrap/start.sh"]
