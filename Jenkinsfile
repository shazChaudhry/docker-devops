pipeline {
  agent {
    docker {
      image 'shazchaudhry/docker-centos:latest'
    }
  }
  stages {
    stage('Build') {
      steps {
        sh 'git --version'
        sh 'terraform --version'
        sh 'ansible --version'
        sh 'mvn --version'
        sh 'java -version'
        sh 'javac -version'
      }
    }
  }
}
