pipeline {
    agent any
    environment {
        PRIVATE_SERVER = "ubuntu@10.0.2.17"   // Private EC2
        SSH_KEY_ID = "private-server-key"
        APP_IMAGE = "node-ci-cd-demo:latest"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'git@github.com:https://github.com/subalakshmir087-dataqueen/ci-cd-pipeline.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $APP_IMAGE .'
            }
        }
        stage('Deploy to Private Server') {
            steps {
                sshagent([env.SSH_KEY_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no $PRIVATE_SERVER '
                        docker stop node-app || true
                        docker rm node-app || true
                        docker run -d -p 80:3000 --name node-app $APP_IMAGE
                        '
                    """
                }
            }
        }
    }
}

