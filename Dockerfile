FROM centos:7
MAINTAINER James Wade <jpswade@gmail.com>

ADD http://pkg.jenkins-ci.org/redhat/jenkins.repo /etc/yum.repos.d/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum install -y initscripts php-intl phpunit java jenkins ant wget php-pear git bind-utils
RUN pear install PHP_CodeSniffer && \
    wget https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc && \
    wget https://static.pdepend.org/php/latest/pdepend.phar --no-check-certificate && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend && \
    wget https://static.phpmd.org/php/latest/phpmd.phar --no-check-certificate && chmod +x phpmd.phar && mv phpmd.phar /usr/local/bin/phpmd && \
    wget https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd && \
    wget http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/bin/phpdox

ADD setup.sh /srv/setup.sh
ADD example.xml /srv/example.xml
RUN sh /srv/setup.sh

EXPOSE 8080

CMD service jenkins start && tail -f /var/log/jenkins/jenkins.log