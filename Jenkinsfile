pipeline {
    agent any

    stages {
        stage('Clone'){
            steps {
                echo 'Clone'
                git credentialsId: 'token_for_github', url: 'https://github.com/ericsong917/terraform_project'
            }
        }
        stage('terraformapply'){
            steps{
                dir('/var/lib/jenkins/workspace/sprint2/terraform') { // <<------------
                    sh 'terraform apply -auto-approve'
                }

            }
        }
    }
    
}
