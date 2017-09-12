[![Build Status](https://travis-ci.org/jpswade/jenkins-php-ci.svg?branch=master)](https://travis-ci.org/jpswade/jenkins-php-ci)

# Jenkins PHP CI

This is a Jenkins setup for PHP continuous integration.

### What is this repository for? ###

* Jenkins
* PHP
* Continuous Integration

### How do I get set up? ###

#### Build

    docker-machine ip || docker-machine start
    eval $(docker-machine env)
    docker build . -t jenkins-php-ci
    
### Run

    docker run -p 8080:8080 -v /var/jenkins_home jenkins-php-ci

### Contribution guidelines ###

* Pull requests are welcome

### Who do I talk to? ###

* [James Wade](https://wade.be/)