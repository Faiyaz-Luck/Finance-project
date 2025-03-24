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
                        sh 'docker build -t faiyazluck/finance-me-service:${BUILD_NUMBER} .'
                        sh 'docker push faiyazluck/finance-me-service:${BUILD_NUMBER}'
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
                    sh 'docker-compose up -d'
                }
            }

            stage('Deploy to Production') {
                when {
                    expression { currentBuild.result == 'SUCCESS' }
                }
                steps {
                    echo 'Deploying to Production...'
                    sh 'ansible-playbook -i ansible/prod-hosts ansible/deploy.yml'
                    sh 'docker-compose -f prod-docker-compose.yml up -d'
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
