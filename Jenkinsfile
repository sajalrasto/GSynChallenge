pipeline {
     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent any

    // tools {
    //     // Define the Terraform tool installation
    //     terraform 'Terraform'
    // }
    
        stages {
            stage('Git Clone') {
                steps {
                    // git credentialsId: 'sajalgitcred', url:  'https://github.com/sajalrasto/GSynChallenge.git'
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'sajalgitcred', url: 'https://github.com/sajalrasto/GSynChallenge.git']])

                }
            }

            // stage('Install Terraform') {
            //     // when {
            //     //     // Only run this stage for the master branch
            //     //     branch 'main'
            //     // } 


            //     steps {
            //         // Download the Terraform binary
            //         // sh 'curl -LO https://releases.hashicorp.com/terraform/latest/terraform-linux-amd64'

            //         // // Make the Terraform binary executable
            //         // sh 'chmod +x terraform-linux-amd64'

            //         // // Move the Terraform binary to the PATH
            //         // sh 'sudo mv terraform-linux-amd64 /usr/local/bin/terraform'

            //         // sh 'sudo yum install -y yum-utils shadow-utils'
            //         // sh 'sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo'
            //         // sh 'sudo yum -y install terraform'

            //         sh 'wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip'
            //         sh 'unzip terraform_1.5.7_linux_amd64.zip'
            //         sh 'chmod +x terraform'
            //         sh 'sudo mv terraform /usr/local/bin/terraform'
            //     }
            // }

            // stage('AWS CLI install') {
            //     steps {
            //         // download awscli
            //         sh 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'



            //         // unzip awscli
            //         sh 'unzip awscliv2.zip'
                    
            //         //install
            //         sh 'sudo ./aws/install'
            //     }
            // }
            
            stage('Plan Terraform') {
                steps {
                    // Set the Terraform workspace
                    sh 'terraform init -backend-config=backend.tfvars -reconfigure -input=false'

                    // Run Terraform plan
                    sh 'terraform plan  -out=plan.out'
                }
            }

            stage('Apply Terraform') {
                steps {
                    // Apply the Terraform plan
                sh 'terraform apply -input=false -auto-approve'
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
