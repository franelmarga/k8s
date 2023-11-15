# K8s Repository

This repository is a comprehensive collection of resources and tools designed to simplify the deployment of Kubernetes on Amazon EC2. It includes YAML templates for various Kubernetes resources, as well as infrastructure as code (IaC) scripts using Terraform and Ansible.

## Directory Structure

- `yaml_examples`: Contains YAML templates that serve as starting points for creating various Kubernetes resources. These templates are designed to be highly configurable and serve as a guide for Kubernetes deployments.

- `tools`: Provides the necessary IaC scripts to deploy a Kubernetes cluster on Amazon EC2 with ease. Utilizing Terraform for provisioning and Ansible for configuration management.

## Getting Started

To get started with this repository, you'll want to have a basic understanding of Kubernetes, Terraform, and Ansible. Ensure you have the following prerequisites installed:

- `kubectl`: The Kubernetes command-line tool, `kubectl`, allows you to run commands against Kubernetes clusters.
- `terraform`: An open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.
- `ansible`: An open-source software provisioning, configuration management, and application-deployment tool enabling infrastructure as code.

### Kubernetes YAML Examples

Navigate to the `yaml_examples` directory to find a collection of YAML templates. These templates can be used to deploy standard Kubernetes resources such as Deployments, Services, and Ingress.

### Tools for Deployment

The `tools` directory contains Terraform and Ansible scripts necessary to provision and manage the infrastructure on AWS EC2.

1. **Terraform**: Change to the `tools/terraform` directory and deploy the cluster. AWS credentials needed to be configured (you can check with `aws sts get-caller-identity`).

2. **Ansible**: After your infrastructure is provisioned, use the Ansible playbooks in the `tools/ansible` directory to configure your Kubernetes cluster.

