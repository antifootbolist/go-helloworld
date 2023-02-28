pipeline {
    agent any

    environment {
        PROD_IP = '51.250.71.203'          // Need to change
        APP_PORT = '8081'                  // Need to change
        APP_NAME = 'go-hw-app'
        DOCKER_HUB_USER = 'antifootbolist' //Need to change
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/antifootbolist/go-helloworld.git',
                    branch: 'main'
            }
        }
        stage('Build Docker Image') {
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
            steps {
                script {
                    // Don't forget to create docker_hub_login credential to autorize on Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage ('Deploy to Prod') {
            steps {
                // Don't forget to create prod_login credential to autorize on Prod server
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
