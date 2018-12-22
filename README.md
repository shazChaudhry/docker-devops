# **Work In Progress**


## Objectives
- Create and configure a [DevOps](https://en.wikipedia.org/wiki/DevOps) environment in a public cloud; [AWS](https://aws.amazon.com/)
- The infrastructure created will need to be reproducable and predictable
- The infrastructure created will be 2x [Swarm](https://docs.docker.com/engine/swarm/) clusters to support the following:
  - [CI / CD](https://en.wikipedia.org/wiki/CI/CD) platform consisting of [GitLab](https://about.gitlab.com/), [Jenkins](https://jenkins.io/), [SonarQube](https://www.sonarqube.org/) and [Nexus](https://www.sonatype.com/)
  - Logging and Monitoring platform consisting of [Elastic Stack](https://www.elastic.co/)

In order to achieve the stated objectives, the following will need to be automated via a Jenkins/2 declarative pipeline:
- Recreate _(destroy / create)_ the infrastructure using [Terraform](https://www.terraform.io/)
- Configure the infrastructure using [Ansible](https://www.ansible.com/)
- Deploy the application stacks in docker swarm mode

![Pipeline picture to be added](./pics/pipeline.png)

NOTE:
> The Jenkins/2 pipeline to achieve the above objectives have been tested in a [Vagrant CentOS/7 VM](https://app.vagrantup.com/centos/boxes/7) on a Windows 10 pro machine only

> Vagrant CentOS/7 VM on my Windows machine was necessary as I was not able to install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

## Prerequisites
1. Good and consistent internet connection
1. Windows 10 pro machine to act as a dev environment from where to launch the automated infrastructure pipeline
1. latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](https://www.vagrantup.com/) and [Git BASH](https://gitforwindows.org/) are installed on the dev machine
1. Install vagrant-vbguest plugin: `vagrant plugin install vagrant-vbguest`
1. Install vagrant-hostmanager plugin: `vagrant plugin install vagrant-hostmanager`

## Instructions
1. Start a Git Bash shell and change to a suitable directory _(e.g. $HOME/github)_
1. Clone this repo: `git clone https://github.com/shazChaudhry/docker-jenkins-pipeline.git` and change the directory _(e.g. $HOME/github/docker-jenkins-pipeline)_
1. Create a CentOS/7 VM in a VirtualBox and then SSH to it: `clear; vagrant destroy --force; vagrant box update; vagrant box prune; vagrant up; vagrant ssh`.
1. Change to the Vagrant synced folder: `cd /vagrant`
1. Start [jenkinsci/blueocean](https://hub.docker.com/r/jenkinsci/blueocean) by following the command below:
```
        docker container run -d \
        --rm \
        --user root \
        --name jenkins \
        --publish 8080:8080 \
        --volume jenkins-data:/var/jenkins_home \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume $PWD:/home/github/docker-devops \
        --volume $HOME:/root \
        jenkinsci/blueocean
```
1. After a few moments, Jenkins should be accessible at [http://devops:8080](http://devops:8080)
1. You will need an adminstrator password in order to unlock Jenkins: `docker container exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
1. Once Jenkins has been unlocked with the admin password, select "Install suggested plugins" on customize Jenkins page. You will then need to follow the on-screen instructions to complete the setup
