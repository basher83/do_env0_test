# do_env0_test

This repository demonstrates deploying a DigitalOcean droplet using Terraform, configuring it with Ansible, and managing the workflow with env0.

## Overview
- **Infrastructure as Code:** Uses Terraform to provision a DigitalOcean droplet.
- **Configuration Management:** Uses Ansible to configure the droplet after creation.
- **Orchestration:** All steps are managed and automated via env0.

## Prerequisites
- DigitalOcean account and API token
- SSH key pair (public and private)
- env0 account

## Setup
1. **Configure env0 Variables:**
   - `do_token`: Your DigitalOcean API token (Sensitive)
   - `STAGING_PUBLIC_KEY`: The public SSH key to be injected into the droplet (Sensitive)
   - `STAGING_PRIVATE_KEY`: The private SSH key for Ansible to connect (Sensitive)

2. **Deploy:**
   - env0 will run the workflow defined in `env0.yml`:
     - Provisions a droplet with Terraform (`main.tf`)
     - Injects the public SSH key via cloud-init (`digitalocean.tftpl`)
     - Runs Ansible playbook (`configure.yml`) to configure the droplet

## File Structure
- `main.tf`: Terraform configuration for DigitalOcean droplet
- `digitalocean.tftpl`: Cloud-init template for initial droplet setup
- `configure.yml`: Ansible playbook for post-provisioning configuration
- `env0.yml`: env0 workflow definition
- `files/aliases.zsh`: Custom shell aliases for the droplet

## Test Docker Container Deployment

As part of the Ansible configuration, a test nginx Docker container is deployed to the droplet and exposed on port 8080. You can verify the deployment in two ways:

1. **Check Ansible Output:**
   - The Ansible playbook prints the nginx homepage content to the output after deployment.

2. **Access via Browser:**
   - Visit `http://<droplet_ip>:8080` in your browser to see the nginx welcome page.

This confirms that Docker is running and the container was successfully deployed by Ansible.

## Notes
- This is a test repository for learning and experimenting with env0, Terraform, and Ansible.
- SSH key handling is managed via env0 variables for security and flexibility.

## References
- [env0 Documentation](https://docs.env0.com/)
- [Terraform DigitalOcean Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)

