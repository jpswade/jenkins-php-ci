#!/usr/bin/env bash
set -e
service jenkins start
JENKINS_HOME=/var/lib/jenkins
printf 'Waiting for Jenkins initialise'
until [ -f ${JENKINS_HOME}/config.xml ]; do printf '.' && sleep 5; done && echo .
printf 'Waiting for Jenkins to become available'
until [ -f jenkins-cli.jar ]; do wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar && printf . && sleep 5; done && echo .
until [ -f ${JENKINS_HOME}/secrets/initialAdminPassword ]; do printf '.' && sleep 5; done && echo .
ADMIN_PASS=$(cat ${JENKINS_HOME}/secrets/initialAdminPassword)
MY_CRUMB=$(curl -s -u "admin:$ADMIN_PASS" 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
curl -L https://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -u "admin:$ADMIN_PASS" -H 'Accept: application/json' -H "$MY_CRUMB" -d @- http://localhost:8080/updateCenter/byId/default/postBack
service jenkins restart
until [[ $(curl -s -w "%{http_code}" -u "admin:$ADMIN_PASS" http://localhost:8080 -o /dev/null) == "200" ]]; do printf '.' && sleep 5; done;
until curl --silent http://localhost:8080 -u "admin:$ADMIN_PASS" | grep -v "Please wait"; do printf '.' && sleep 5; done
java -jar jenkins-cli.jar -auth admin:$ADMIN_PASS -s http://localhost:8080 install-plugin ansicolor git checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit
cat example.xml | java -jar jenkins-cli.jar -auth admin:$ADMIN_PASS -s http://localhost:8080 create-job php-template
java -jar jenkins-cli.jar -auth admin:$ADMIN_PASS -s http://localhost:8080 reload-configuration
java -jar jenkins-cli.jar -auth admin:$ADMIN_PASS -s http://localhost:8080 safe-restart
