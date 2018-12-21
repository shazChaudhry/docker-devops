# Work In Progress

NOTE:
> This image has been tested on Windows 10 pro machine and in a VirtualBox only. It is assumed you already have installed VirtualBox, Vagrant and Git Bash on your machine.

# Instructions
1. Start a Git Bash shell and change to a suitable directory _(e.g. $HOME/github)_
1. Clone this repo: `git clone https://github.com/shazChaudhry/docker-devops.git` and change the directory _(e.g. $HOME/github/docker-devops)_
1. Create two CentOS nodes in a VirtualBox and then SSH to one of them: `vagrant up; vagrant ssh devops1`.
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
      jenkinsci/blueocean
```
1. After a few moments, Jenkins should be accessible at [http://devops1:8080](http://devops1:8080)
1. You will need an adminstrator password in order to unlock Jenkins: `docker container exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
1. Once Jenkins has been unlocked with the admin password, select "Install suggested plugins" on customize Jenkins page. You will then need to follow the on-screen instructions to complete the setup
