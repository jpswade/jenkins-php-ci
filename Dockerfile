FROM centos:7
MAINTAINER James Wade <jpswade@gmail.com>
ENV JENKINS_HOME=/root/.jenkins
ADD http://pkg.jenkins-ci.org/redhat/jenkins.repo /etc/yum.repos.d/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum install -y php-intl phpunit java jenkins ant wget php-pear git && \
    pear install PHP_CodeSniffer && \
    wget https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc && \
    wget https://static.pdepend.org/php/latest/pdepend.phar --no-check-certificate && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend && \
    wget https://static.phpmd.org/php/latest/phpmd.phar --no-check-certificate && chmod +x phpmd.phar && mv phpmd.phar /usr/local/bin/phpmd && \
    wget https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd && \
    wget http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/bin/phpdox && \
    chkconfig jenkins on
RUN mkdir -p $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/git.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/checkstyle.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/cloverphp.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/crap4j.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/dry.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/htmlpublisher.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/jdepend.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/plot.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/pmd.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/violations.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/warnings.hpi -P $JENKINS_HOME/plugins && \
wget http://updates.jenkins-ci.org/latest/xunit.hpi -P $JENKINS_HOME/plugins

EXPOSE 8080

CMD /usr/bin/java -jar /usr/lib/jenkins/jenkins.war