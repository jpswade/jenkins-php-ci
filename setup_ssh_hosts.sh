#!/usr/bin/env bash
mkdir -p ~/.ssh
[[ -e ~/.ssh/id_rsa ]] || ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
ssh_hosts="github.com bitbucket.org"
for ssh_host in ${ssh_hosts[@]}; do
    ssh_host_ips="$(host ${ssh_host} | awk '/has address/ { print $4 }')"
    ssh-keygen -R ${ssh_host}
    ssh-keyscan -H ${ssh_host} >> ~/.ssh/known_hosts
    for ssh_host_ip in ${ssh_host_ips[@]}; do
        ssh-keygen -R ${ssh_host_ip}
        ssh-keygen -R ${ssh_host},${ssh_host_ip}
        ssh-keyscan -H ${ssh_host},${ssh_host_ip} >> ~/.ssh/known_hosts
        ssh-keyscan -H ${ssh_host_ip} >> ~/.ssh/known_hosts
    done
done