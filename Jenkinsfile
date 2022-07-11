pipeline {

    agent any

    tools {
       jdk "JDK_11"
    }

    environment {
        registry="vconte/student-microservice-jenkins"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }


    stages {

        stage('maven build') {
             steps {
                withMaven ( maven: 'maven') {
                     sh "mvn clean"
                     sh "mvn install"
                }
            }
            post {
                always {
                    junit testResults: '**/target/surefire-reports/*.xml', allowEmptyResults: false
                }
            }
        }

        stage('Building image') {
            steps {
                script {
                   dockerImage = docker.build("${registry}:latest")
                }
            }
        }

        stage('Deploy to Artifactory') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

    }
}