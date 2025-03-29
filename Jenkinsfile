    pipeline {
        agent any
        
        stages {
            stage('Checkout Code for banking project') {
                steps {
                    git branch: 'main', url: 'https://github.com/Faiyaz-Luck/Finance-project.git'
                }
            }
            
            stage('Build with Maven for banking project') {
                steps {
                    sh 'mvn clean package'
                }
            }

            stage('Run Unit Tests for banking project') {
                steps {
                    sh 'mvn test'
                }
            }

            stage('Docker Build and Push for banking project') {
                steps {
                    script {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                            sh 'docker build --platform linux/arm64 -t faiyazluck/finance-me-service:${BUILD_NUMBER} .'
                            sh 'docker tag faiyazluck/finance-me-service:${BUILD_NUMBER} faiyazluck/finance-me-service:latest'
                            sh 'docker push faiyazluck/finance-me-service:${BUILD_NUMBER}'
                            sh 'docker push faiyazluck/finance-me-service:latest'
                        }
                    }
                }
            }
            stage('Infrastructure Provisioning with Terraform') {
                steps {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }

            stage('Configuration with Ansible') {
                steps {
                    sh 'ansible-playbook -i ansible/hosts ansible/deploy.yml'
                }
            }

            stage('Deployment to Test Server') {
                steps {
                }
            }

            stage('Deploy to Production') {
                when {
                    expression { currentBuild.result == 'SUCCESS' }
                }
                steps {
                    echo 'Deploying to Production...'
                    sh 'ansible-playbook -i ansible/prod-hosts ansible/deploy.yml'
                }
            }
        }

        post {
            success {
                echo 'Deployment Successful!'
            }
            failure {
                echo 'Deployment Failed!'
            }
        }
    }
