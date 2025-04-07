pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'faiyazluck/finance-me-service'
        DOCKER_TAG = "${params.DOCKER_TAG}"
    }

    parameters {
        string(name: 'DOCKER_TAG', defaultValue: 'latest', description: 'Tag for Docker image')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Faiyaz-Luck/Finance-project.git'
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.8.5-openjdk-17'
                }
            }
            steps {
                sh 'mvn test'
            }
        }

stage('Infrastructure Provisioning with Terraform') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'aws-cred-id',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
            sh 'terraform init'
            sh 'terraform apply -auto-approve'
        }
    }
}


        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker --version || (echo 'Docker not installed!' && exit 1)"
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${params.DOCKER_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-cred-id', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE_NAME}:${params.DOCKER_TAG}"
                }
            }
        }

     stage('Deploy to Test Server') {
    steps {
        script {
            sh '''
                export ANSIBLE_CONFIG=ansible/ansible.cfg
                ansible --version
                ansible-playbook -i ansible/hosts ansible/deploy.yml
            '''
        }
    }
}

stage('Deploy to Prod Server') {
    steps {
        script {
            sh '''
                export ANSIBLE_CONFIG=ansible/ansible.cfg
                ansible-playbook -i ansible/hosts ansible/deploy-prod.yml
            '''
        }
    }
}

    }

    post {
        success {
            echo " Deployment succeeded!"
        }
        failure {
            echo " Deployment failed. Please check logs."
        }
        always {
            echo " Pipeline execution completed."
        }
    }
}
