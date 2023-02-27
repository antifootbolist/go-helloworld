pipeline {
    agent any

    environment {
        PROD_IP = '51.250.71.203'
        APP_PORT = '80'
        APP_NAME = 'go-hw-app'
        DOCKER_HUB_USER = 'antifootbolist'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/antifootbolist/go-helloworld.git',
                    branch: 'main'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    app = docker.build("${DOCKER_HUB_USER}/${APP_NAME}")
                    app.inside {
                        sh 'echo $(curl localhost:8080)'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage ('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                withCredentials ([usernamePassword(credentialsId: 'prod_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker pull ${DOCKER_HUB_USER}/${APP_NAME}:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker stop ${APP_NAME}\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker rm ${APP_NAME}\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker run --restart always --name ${APP_NAME} -p ${APP_PORT}:8080 -d ${DOCKER_HUB_USER}/${APP_NAME}:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}
