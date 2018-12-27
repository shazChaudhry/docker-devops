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
          echo "These tools are in stalled in the docker agent - shazchaudhry/docker-centos:latest "
          git --version
          terraform --version
          ansible --version
          mvn --version
          java -version
          javac -version
        '''
      }
    }
    stage('Build ELK infrastructure') {
      steps {
        sh '''
          cd terraform
          terraform init
          terraform destroy -auto-approve
          terraform apply -auto-approve
        '''
      }
    }
    stage('Configure ELK infrastructure') {
      steps {
        sh '''
          cd ansible
          pwd
          ls -latr
        '''
      }
    }
  }
}
