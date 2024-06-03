## Deployment of a Webpage on AWS Using Terraform
The code/projects illustrates the launching of a simple webpage on AWS using the IaC tool Terraform to manage the infrastructure. This launching invloves building up a Virtual Private cloud, security groups, subnets, and an Elastic Compute Cloud (EC2) instance which is running on a Apache web server.

## Important Prerequisites
It is neccessary to ensure the following details prior to starting:

Have a AWS Account
Ensure that the Amazon Web Service CLI is configured with the correct and right permissions.
Ensure to have Terraform installed on your computer. Here is a link to download Terraform (https://www.terraform.io/downloads.html)
Set up your SSH key pair in other to access the Elastic Compute Cloud instance.
Installation
Step 1: Clone the Repository

  git clone
Step 2: Configure AWS Credentials

    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_SECRET_KEY"
Step 3: Initialize Terraform

    terraform init
Step 4: Plan the Infrastructure

    terraform plan
Step 5: Run the Terraform Apply

    terraform Apply
Deployment
To install and enable Apache2 on this project run.

  sudo systemctl enable apache2
You can also check to make sure apache2 is enabled by running:

  sudo systemctl status apache2
Ensure you are connected to your EC2 instance before running the above commands.

🔗 Links
Terraform Documentation (https://registry.terraform.io/)

AWS Documentation (https://docs.aws.amazon.com/)

Apache2 Documentation (https://httpd.apache.org/docs/)

Wget (https://www.gnu.org/software/wget/)

Gitignore Documentation (https://git-scm.com/docs/gitignore)

To view the hosted webpage on the AWS server, the below Public IPv4 Address can be copied into a new window tab.

Public IPv4 Address: 100.27.95.114

Tech Stack
IaC Tool: Terraform

Development Platform: VS code, Terminal
