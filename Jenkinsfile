pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                git credentialsId: 'sajalgitcred', url:  'https://github.com/sajalrasto/GSynChallenge.git'
            }
        }

        stage('Install Terraform') {
            when {
                // Only run this stage for the master branch
                branch 'master'
            }

            steps {
                // Download the Terraform binary
                sh 'curl -LO https://releases.hashicorp.com/terraform/latest/terraform-linux-amd64'

                // Make the Terraform binary executable
                sh 'chmod +x terraform-linux-amd64'

                // Move the Terraform binary to the PATH
                sh 'sudo mv terraform-linux-amd64 /usr/local/bin/terraform'
            }
        }

        stage('Plan Terraform') {
            steps {
                // Set the Terraform workspace
                terraform init -backend-config=backend.tfvars -reconfigure -input=false

                // Run Terraform plan
                terraform plan -var-file=variables.tfvars -out=plan.out
            }
        }

        stage('Apply Terraform') {
            steps {
                // Apply the Terraform plan
                terraform apply -input=false -auto-approve -out=apply.out
            }
        }
    }

    post {
        always {
            // Archive the Terraform state file
            archiveArtifacts artifacts: 'terraform.tfstate'
        }
    }
}
