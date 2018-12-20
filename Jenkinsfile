pipeline {
  agent { docker { image 'shazchaudhry/docker-centos'  } }
  stages {
    stage('Build') {
      steps {
        sh 'mvn --version'
        sh 'terraform --version'
        sh 'ansible --version'
        sh 'java -version'
        sh 'javac -version'
        sh 'git -version'
      }
    }
  }
}
