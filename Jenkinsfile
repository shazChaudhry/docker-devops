pipeline {
  agent {
    docker {
      image 'shazchaudhry/docker-centos:latest'
    }
  }
  stages {
    stage('Check version of tools') {
      steps {
        sh '''
          git --version
          terraform --version
          ansible --version
          mvn --version
          java -version
          javac -version
        '''
      }
    }
    stage('Build infrastructure') {
      steps {
        sh '''
          cd terraform
          terraform init
          terraform plan
        '''
      }
    }
  }
}
