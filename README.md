# Work In Progress
This repo contains a two-node docker swarm cluster. Details of this cluster can be found https://github.com/shazChaudhry/vagrant

# Instructions
1. Create two CentOS nodes in a VirtualBox: `vagrant up; vagrant ssh`.
1. Start [jenkinsci/blueocean](https://hub.docker.com/r/jenkinsci/blueocean) :
```
      docker container run -d \
      --rm \
      --user root \
      --name jenkins \
      --publish 8080:8080 \
      --volume jenkins-data:/var/jenkins_home \
      --volume /var/run/docker.sock:/var/run/docker.sock \
      --volume $PWD:/home/GitHub \
      jenkinsci/blueocean
```
1. Jenkins is accessible at http://node1:8080
1. You will need an adminstrator password in order to unlock Jenkins: `docker container exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
1. Once Jenkins has been unlocked with the admin password, select "Install suggested plugins" on customize Jenkins page. You will then need to follow the on-screen instructions to complete the setup 
