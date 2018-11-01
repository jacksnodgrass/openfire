pipeline {

  agent any

  stages {
    stage ('Build and Push Docker Openfire Container') {
      steps {
        sh "make build"
        sh "make push"
      }
    }
  }
}