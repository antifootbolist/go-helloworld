pipeline {
    agent any

    environment {
        PROD_IP = '51.250.71.203'
        APP_PORT = '80'
        APP_NAME = 'my-go-app'
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
                sh 'docker build -t ${APP_NAME} .'
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
                sh 'docker stop ${APP_NAME} || true'
                sh 'docker rm ${APP_NAME} || true'
                sh 'docker run -d --name ${APP_NAME} -p ${APP_PORT}:8080 ${APP_NAME}'
            }
        }
    }
}
