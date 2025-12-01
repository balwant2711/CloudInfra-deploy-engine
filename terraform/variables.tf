variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1" #north virginia
}

# ⚠ TEMPORARY USE ONLY – put real values in terraform.tfvars
variable "aws_access_key" {
  description = "AWS Access Key (TEMP USE ONLY – DO NOT COMMIT)"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key (TEMP USE ONLY – DO NOT COMMIT)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Free tier eligible
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH access"
  type        = string
  default     = "my-ec2-key"
}

variable "domain_name" {
  description = "Your domain name from GoDaddy (e.g. example.com)"
  type        = string
}

variable "github_repo_url" {
  description = "Public GitHub repo URL of your website"
  type        = string
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed to SSH into the instance (e.g. your IP/32). Use 0.0.0.0/0 only for demo."
  type        = string
  default     = "0.0.0.0/0"
}
