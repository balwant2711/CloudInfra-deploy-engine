############################
# DATA SOURCES
############################

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets in that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

############################
# SECURITY GROUP
############################

resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Allow SSH, HTTP and HTTPS"
  vpc_id      = data.aws_vpc.default.id

  # SSH
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_ssh_cidr]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-web-sg"
  }
}

############################
# EC2 INSTANCE
############################

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id = element(data.aws_subnets.default.ids, 0)
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name

  # User data script to install Apache & clone GitHub repo
  user_data = <<-EOF
              #!/bin/bash
              yum update -y

              # Install Apache & Git
              yum install -y httpd git

              systemctl enable httpd
              systemctl start httpd

              # Remove default content
              rm -rf /var/www/html/*

              # Clone website from GitHub
              git clone ${var.github_repo_url} /var/www/html/

              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html

              # Fallback page if repo is empty
              if [ ! -f /var/www/html/index.html ]; then
                echo "<h1>Terraform Deployed Website on AWS</h1>" > /var/www/html/index.html
              fi
              EOF

  tags = {
    Name = "terraform-web-server"
  }
}

############################
# ELASTIC IP
############################

resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name = "terraform-web-eip"
  }
}

############################
# ROUTE 53 - HOSTED ZONE & RECORDS
############################

# Hosted Zone for your domain (must match GoDaddy domain)
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

# Root domain A record (example.com)
resource "aws_route53_record" "root_a_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [aws_eip.web_eip.public_ip]
}

# www subdomain (www.example.com)
resource "aws_route53_record" "www_a_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.web_eip.public_ip]
}
