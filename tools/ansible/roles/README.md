# Ansible k8s deployment

Terraform will give 3 outputs IPs you will need to replace in `inventory.ini`, and provide the path to the corresponding .pem key files for the instances that have been created.

Execute `ansible-playbook -i inventory.ini main.yaml` to configure the kubernetes cluster. IPs and .pem path needs to be replaced in `inventory.ini`. 
