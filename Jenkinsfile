pipeline {
  agent any 
  environment {
    AWS_ACCESS_KEY_ID = credentials('awsAccessKeyId') 
    AWS_SECRET_ACCESS_KEY = credentials('awsSecretAccessKey') 
    AWS_DEFAULT_REGION = 'ap_northeast-2'}
  stages {
    stage('Clone') {
      steps {
        echo 'Clone'
        git credentialsId: 'token_for_github', url: 'https://github.com/ericsong917/terraform_project'
        sh('export')
      }
    }
    stage('terraformapply') {
        steps {
            echo 'terraform apply'
            dir('/var/lib/jenkins/workspace/sprint2/terraform') { 
            sh ('terraform init') 
            sh ('terraform apply -auto-approve') }
        }
    }
  }
}