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
<<<<<<< HEAD
                echo 'terraform apply'
                sh('cd terraform')
                sh('terraform apply -auto-approve')
=======
                dir('/var/lib/jenkins/workspace/sprint2/terraform') { // <<------------
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve' //test
                }

>>>>>>> 4236e87e294076b55721b74aa07317b7543c6989
            }
        }
    }
    
}
