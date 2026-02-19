pipeline {
    agent any

    environment {
        PRIVATE_SERVER = "ubuntu@10.0.2.121"
        SSH_KEY_ID = "private-server-key"
        APP_IMAGE = "subicloudevops/node-ci-cd-demo:latest"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                url: 'git@github.com:subalakshmir087-dataqueen/ci-cd-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $APP_IMAGE .'
            }
        }

        stage('Push Image to Docker Hub') {
    steps {
        script {
            docker.withRegistry('', 'dockerhub-credentials') {
                docker.image('subicloudevops/node-ci-cd-demo:latest').push()
            }
        }
    }
}


        stage('Deploy to Private Server') {
    steps {
        sshagent(['private-server-key']) {
            sh """
            ssh -o StrictHostKeyChecking=no ubuntu@10.0.2.121 '
            docker stop node-app || true &&
            docker rm node-app || true &&
            docker pull subicloudevops/node-ci-cd-demo:latest &&
            docker run -d -p 80:3000 --name node-app subicloudevops/node-ci-cd-demo:latest
            '
            """
        }
    }
}
    }
}
