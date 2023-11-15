# Tools Directory

This directory contains various utility scripts and tools to help manage and configure your Kubernetes environment. These tools are designed to streamline the creation, deployment, and maintenance of Kubernetes clusters, particularly in cloud environments like AWS.

## Contents

- `update_ip.sh`: A script that updates the IP address used for external connections to the Kubernetes control plane. This is particularly useful when dealing with dynamic IP addresses that may change, such as when restarting an EC2 instance.

- `terraform`: This subdirectory includes Terraform configurations for provisioning a basic Kubernetes cluster on AWS. The configuration is set to create one master node and two worker nodes, all of which are `t2.micro` instances, to form the Kubernetes cluster.

## Using the Terraform Scripts

To use the Terraform scripts to deploy your Kubernetes cluster on AWS, follow these steps:

1. **Initialize Terraform**:
   Navigate to the `terraform` directory and run the following command to initialize the Terraform environment:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```
