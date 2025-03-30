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

    stages {
        stage('Docker Build and Run for banking project') {
            steps {
                script {
                    sh 'docker build -t finance-me-service .'
                    sh 'docker run -d -p 8080:8080 finance-me-service'
                }
            }
        }
    }
            // stage('Infrastructure Provisioning with Terraform') {
            //     steps {
            //         sh 'terraform init'
            //         sh 'terraform apply -auto-approve'
            //     }
            // }

            // stage('Configuration with Ansible') {
            //     steps {
            //         sh 'ansible-playbook -i ansible/hosts ansible/deploy.yml'
            //     }
            // }

            stage('Deploy to Test server'){
                steps{
                    echo 'Deploying to test server'
                }
            }

stage('Deploy to Production') {
    steps {
        script {
            echo 'Deploying to Production...'
            // sh 'ansible-playbook -i ansible/hosts ansible/deploy-prod.yml'
        }
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
