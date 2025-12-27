pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION = "ap-south-1"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage("Checkout") {
      steps {
        cleanWs()
        checkout scm
      }
    }

    stage("Preflight Checks") {
      steps {
        sh '''
          echo "🔍 Verifying Jenkins Agent Environment"
          terraform -version
          ansible --version
          
        '''
      }
    }

    stage("Terraform Init") {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
        ]) {
          dir('Terraform/envs/dev') {
            sh 'terraform init -input=false'
          }
        }
      }
    }

    stage("Terraform Validate") {
      steps {
        dir('Terraform/envs/dev') {
          sh 'terraform validate'
        }
      }
    }

    stage("Terraform Apply") {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
        ]) {
          dir('Terraform/envs/dev') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    stage("Verify Dynamic Inventory") {
      steps {
        dir('Ansible') {
          sh 'ansible-inventory -i inventory/dynamic_inventory.py --list'
        }
      }
    }

    stage("Ansible via SSM") {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
        ]) {
          dir('Ansible') {
            sh 'ansible-playbook playbooks/playbook.yml'
          }
        }
      }
    }

    stage("⏸ Pause for Screenshots & Manual Verification") {
      steps {
        input message: '''
Pipeline SUCCESS ✅

📸 Take screenshots now:
- Jenkins Stage View
- Terraform Apply Output
- EC2 Running
- SSM Managed Instance (Online)
- Ansible Ping Success

Click CONTINUE to destroy infrastructure.
'''
      }
    }
  }

  post {

    success {
      echo "✅ Pipeline successful — destroying infra after approval"
      withCredentials([
        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
      ]) {
        dir('Terraform/envs/dev') {
          sh 'terraform destroy -auto-approve'
        }
      }
    }

    failure {
      echo "❌ Pipeline failed — destroying infra immediately"
      withCredentials([
        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
      ]) {
        dir('Terraform/envs/dev') {
          sh 'terraform destroy -auto-approve'
        }
      }
    }

    always {
      echo "🧹 Cleaning Jenkins workspace"
      cleanWs()
    }
  }
}
