# **This is Work In Progress**


## Objectives
- Create and configure a [DevOps](https://en.wikipedia.org/wiki/DevOps) environment in [AWS](https://aws.amazon.com/)
- Use Open Source Software _(OSS)_ or free trial versions as much as possible
- The DevOps environment created will need to be reproducible and predictable
- The DevOps environment created will consist of two [Swarm](https://docs.docker.com/engine/swarm/) clusters _([VPC peering](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html))_ to support the following:
  - [CI / CD](https://en.wikipedia.org/wiki/CI/CD) platform made up of [GitLab](https://about.gitlab.com/), [Jenkins](https://jenkins.io/)_(optional)_, [SonarQube](https://www.sonarqube.org/) and [Nexus](https://www.sonatype.com/)
  - Logging and Monitoring platform made up of various members of [Elastic Stack](https://www.elastic.co/products) _(trial version containing full funtionality)_

In order to achieve the stated objectives above, the following will need to be automated via a Jenkins/2 declarative pipeline. The sole purpose of this stand-alone Jenkins instance is to recreate the DevOps environment. This Jenkins instance can be deployed anywhere that has docker and internet access:
- Recreate _(terminate / create)_ the infrastructure using [Terraform](https://www.terraform.io/)
- Configure the infrastructure using [Ansible](https://www.ansible.com/)
- Deploy the application stacks _(CI/CD + Elastic Stack)_ in docker swarm mode

![Pipeline picture to be added](./pics/pipeline.png)

NOTE:
> The Jenkins/2 pipeline to achieve the above objectives have been tested in a [Vagrant CentOS/7 VM](https://app.vagrantup.com/centos/boxes/7) on a Windows 10 pro machine only

## Prerequisites
1. See Prerequisites in the ./terraform directory
1. Fork this repository in GitHub as your forked repo will need to be integrated with Jenkins. Otherwise, you will not be able to modify the pipeline as per you own needs
1. The items below are only required if you are using a Windows 10 machine that does not have [Docker for Windows](https://docs.docker.com/docker-for-windows/install/) installed on it:
    1. Windows 10 pro machine to act as a dev environment from where to launch the automated infrastructure pipeline
    1. latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](https://www.vagrantup.com/) and [Git BASH](https://gitforwindows.org/) are installed on the dev machine
    1. Install vagrant-vbguest plugin: `vagrant plugin install vagrant-vbguest`
    1. Install vagrant-hostmanager plugin: `vagrant plugin install vagrant-hostmanager`


## Create a [CentOS/7](https://www.centos.org/) VM on a Windows machine
It is assumed you have a stable internet connection:
1. Start a Git Bash shell and create a suitable directory and then change to it:
    - mkdir -p  /tmp/github/docker-devops
    - cd /tmp/github/docker-devops
1. Checkout the Vagrantfile: `curl -o Vagrantfile https://raw.githubusercontent.com/shazChaudhry/docker-devops/master/Vagrantfile`
1. Create a CentOS/7 VM in a VirtualBox and then SSH to it: `clear; vagrant destroy --force; vagrant box update; vagrant box prune; vagrant up; vagrant ssh`
1. You are now ready to deploy a stand-alone Jenkins instance in this VM

## Deploy a stand-alone Jenkins instance
It is assumed that Jenkins is being deployed in a secure environment that has internet access and docker installed and that you have followed the prerequisites in [./terraform/README.md](./terraform/README.md)
1. Start [jenkinsci/blueocean](https://hub.docker.com/r/jenkinsci/blueocean) by following the command below in your terminal:
```
        docker container run -d \
        --rm \
        --user root \
        --name jenkins \
        --publish 8080:8080 \
        --volume jenkins-data:/var/jenkins_home \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume $HOME:/root \
        jenkinsci/blueocean
```
1. After a few moments, Jenkins should be accessible at **http://IP_ADDRESS:8080** or at [http://devops:8080](http://devops:8080) if it is running inside a VM that you created above
1. You will need an adminstrator password in order to unlock Jenkins: `docker container exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
1. Once Jenkins has been unlocked with the admin password, select "Install suggested plugins" on customize Jenkins page. You will then need to follow the on-screen instructions to complete the setup

## Integrate Jeknins with the GitHub repo that you forked as part of the prerequisites above
See "Create your Pipeline project in Blue Ocean" section at https://jenkins.io/doc/tutorials/create-a-pipeline-in-blue-ocean/ for instructions on te integration

## Improvements
In this repository, I have used Terraform and Ansible in the infrastructure provisioning and configuring part of the solution as these skills seem to be a lot in demand at the moment. However, for the purpose of achieving the stated objectives above, Terraform and Ansible are strictly speaking not required. Adding layers of these technologies has made the entire solution unnecessarly more complex and difficult to manage.

Instead of using Terraform and Ansible, a production grade self-healing infrastructure could much easily be created using [Docker for AWS](https://docs.docker.com/docker-for-aws/) with next to no effort. In my honest opinion, "Docker for AWS" is a much better option in this scenario as creating a Swarm cluster is dead simple.
