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
          aws sts get-caller-identity
          session-manager-plugin --version
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

    stage("⏸ Pause for Screenshots & Verification") {
      steps {
        input message: '''
Pipeline completed successfully ✅

👉 Take screenshots now:
- Jenkins Pipeline (Stage View)
- EC2 Instance (Running)
- SSM Managed Instance (Online)
- Dynamic Inventory Output
- Ansible Ping Success

Click CONTINUE to destroy infrastructure.
'''
      }
    }
  }

  post {

    always {
      echo "🧨 Destroying infrastructure..."
      withCredentials([
        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
      ]) {
        dir('Terraform/envs/dev') {
          sh 'terraform destroy -auto-approve'
        }
      }
      echo "🧹 Cleaning workspace"
      cleanWs()
    }

    failure {
      echo "❌ Pipeline failed — infra cleanup executed"
    }
  }
}
