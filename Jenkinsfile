pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Faiyaz-Luck/Finance-project.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t finance-me-service .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker tag finance-me-service faiyazluck/finance-me-service:latest'
                    sh 'docker push faiyazluck/finance-me-service:latest'
                }
            }
        }
        stage('Deploy to Test Server') {
            steps {
                sh 'ansible-playbook test-deployment.yml'
            }
        }
        stage('Deploy to Prod Server') {
            steps {
                sh 'ansible-playbook prod-deployment.yml'
            }
        }
    }
}
