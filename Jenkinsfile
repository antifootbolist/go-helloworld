pipeline {
    agent any

    environment {
        // Need to change
        PROD_IP = '51.250.71.203'
        GO_APP_PORT = '8081'
        GO_APP_NAME = 'go-app'
        PY_APP_PORT = '8082'
        PY_APP_NAME = 'py-app'
        NGINX_PORT = '80'
        NGINX_NAME = 'nginx'
        DOCKER_HUB_USER = 'antifootbolist'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/antifootbolist/helloworld.git',
                    branch: 'main'
            }
        }
        stage('Build and Push Docker Images') {
            steps {
                script {
                    def app_names = [env.GO_APP_NAME, env.PY_APP_NAME, env.NGINX_NAME]
                    for (app_name in app_names) {
                        app = docker.build("${DOCKER_HUB_USER}/${app_name}", "-f ${app_name}/Dockerfile .")
                        // Don't forget to create docker_hub_login credential to autorize on Docker Hub
                        docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                            app.push("${env.BUILD_NUMBER}")
                            app.push("latest")
                        }
                    }
                }
            }
        }
        stage ('Deploy Apps to Prod') {
            steps {
                // Don't forget to create prod_login credential to autorize on Prod server
                withCredentials ([usernamePassword(credentialsId: 'prod_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        def app_names = [env.GO_APP_NAME, env.PY_APP_NAME, env.NGINX_NAME]
                        for (app_name in app_names) {
                            if (app_name == env.GO_APP_NAME) {
                                sh 'echo "Deploying Go application"'
                                app_port = env.GO_APP_PORT
                            }
                            if (app_name == env.PY_APP_NAME) {
                                sh 'echo "Deploying Python application"'
                                app_port = env.PY_APP_PORT
                            }
                            if (app_name == env.NGINX_NAME) {
                                sh 'echo "Deploying Nginx Web server"'
                                app_port = env.NGINX_PORT
                            }
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker pull ${DOCKER_HUB_USER}/${app_name}:${env.BUILD_NUMBER}\""
                            try {
                                sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker stop ${app_name}\""
                                sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker rm ${app_name}\""
                            } catch (err) {
                                echo: 'caught error: $err'
                            }
                            if (app_name == env.NGINX_NAME) {
                                sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker run -d --restart always --name ${app_name} --network ${GO_APP_NAME} --network ${PY_APP_NAME} -p ${app_port}:8080 ${DOCKER_HUB_USER}/${app_name}:${env.BUILD_NUMBER}\""
                            } else {
                                sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$PROD_IP \"docker run -d --restart always --name ${app_name} --network ${app_name} -p ${app_port}:8080 ${DOCKER_HUB_USER}/${app_name}:${env.BUILD_NUMBER}\""
                            }
                        }
                    }
                }
            }
        }
    }
}
