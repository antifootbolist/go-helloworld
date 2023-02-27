pipeline {
    agent any

    parameters {
        string(name: 'PROD_IP', description: 'IP address of a production server')
        string(name: 'PROD_PORT', description: 'Port number of app on a production server')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from GitHub
                git credentialsId: 'antifootbolist-github-access-token', url: 'https://github.com/antifootbolist/go-helloworld.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t my-go-app .'
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            environment {
                DOCKER_HOST = 'tcp://${PROD_IP}:2376'
                DOCKER_TLS_VERIFY = '0'
            }
            steps {
                sh 'docker stop my-go-app || true'
                sh 'docker rm my-go-app || true'
                sh 'docker run -d --name my-go-app -p ${PROD_PORT}:8080 my-go-app'
            }
        }
    }
}
