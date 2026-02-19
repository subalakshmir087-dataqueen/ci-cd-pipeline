pipeline {
    agent any
    environment {
        PRIVATE_SERVER = "ubuntu@10.0.2.121"   // Private EC2
        SSH_KEY_ID = "private-server-key"
        APP_IMAGE = "node-ci-cd-demo:latest"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'git@github.com:subalakshmir087-dataqueen/ci-cd-pipeline.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $APP_IMAGE .'
            }
        }
        stage('Deploy to Private Server') {
    steps {
        sshagent(['ubuntu']) {
            sh '''
            ssh -o StrictHostKeyChecking=yes ubuntu@10.0.2.121 << EOF
            docker stop node-app || true
            docker rm node-app || true
            docker pull subicloudevops/node-ci-cd-demo:latest
            docker run -d -p 80:3000 --name node-app subicloudevops/node-ci-cd-demo:latest
            EOF
            '''
        }
    }
}
    }
}
