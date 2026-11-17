# Security Group for Application Load Balancer

resource "aws_security_group" "finserv_alb_sg" {
  name        = "finserv-alb-sg"
  description = "Security group for FinServ Application Load Balancer"
  vpc_id      = aws_vpc.finserv_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "finserv-alb-sg"
  }
}

# Security Group for EKS Worker Nodes

resource "aws_security_group" "finserv_nodes_sg" {
  name        = "finserv-eks-nodes-sg"
  description = "Security group for FinServ EKS worker nodes"
  vpc_id      = aws_vpc.finserv_vpc.id

  ingress {
    description = "Allow communication between worker nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description     = "Allow traffic from ALB to NodePort services"
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    security_groups = [aws_security_group.finserv_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "finserv-eks-nodes-sg"
  }
}