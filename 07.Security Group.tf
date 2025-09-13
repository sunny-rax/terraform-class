resource "aws_security_group" "terraform-sg-ec2" {
  name        = "terraform-sg-ec2"
  description = "for terraform EC2"
  vpc_id      = aws_vpc.terraform-vpc.id
  tags = {
    "Name" = "terraform-sg-ec2"
  }

  ingress {
    from_port   = 0             # 들어오는 트래픽의 시작 포트 번호
    to_port     = 65535         # 들어오는 트래픽의 끝 포트 번호
    protocol    = "tcp"         # 트래픽의 프로토콜
    cidr_blocks = ["0.0.0.0/0"] # 허용할 IP 주소 범위
    description = "for all Allow"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 모든 프로토콜에 대해 나가는 트래픽을 허용
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Bastion SG
resource "aws_security_group" "terraform-sg-bastion" {
  name        = "terraform-sg-bastion"
  description = "for Bastion Server"
  vpc_id      = aws_vpc.terraform-vpc.id
  tags = {
    "Name" = "terraform-sg-bastion"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for ping"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTPS"
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for DB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ALB SG
resource "aws_security_group" "terraform-sg-alb" {
  name   = "for ALB"
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EKS SG
resource "aws_security_group" "terraform-sg-eks-node-group" {
  name   = "for EKS-managed server"
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for ping"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS SG
resource "aws_security_group" "terraform-sg-rds" {
  name   = "for RDS"
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for DB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
