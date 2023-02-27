pipeline {
    agent any

    environment {
        PROD_IP = '51.250.71.203'
        APP_PORT = '80'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from GitHub
                git url: 'https://github.com/antifootbolist/go-helloworld.git',
                    branch: 'main'
            }
        }

        stage('Build') {
            when {
                branch 'main'
            }
            steps {
                sh 'docker build -t my-go-app .'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            environment {
                DOCKER_HOST = 'tcp://${PROD_IP}:2376'
                DOCKER_TLS_VERIFY = '0'
            }
            steps {
                sh 'docker stop my-go-app || true'
                sh 'docker rm my-go-app || true'
                sh 'docker run -d --name my-go-app -p ${APP_PORT}:8080 my-go-app'
            }
        }
    }
}
