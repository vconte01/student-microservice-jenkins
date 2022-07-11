pipeline {

    agent any

    tools {
       jdk "JDK_11"
    }

    environment {
        registry="https://docker-local.artifactory.linksmt.it"
        image="student-microservice-jenkins"
        registryCredential = 'artifactory_credential'
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
                   dockerImage = docker.build("${image}:latest")
                }
            }
        }

        stage('Deploy to Artifactory') {
            steps {
                script {
                    docker.withRegistry( registry, registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

    }
}