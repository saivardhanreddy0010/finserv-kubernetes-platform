output "configured_region" {
  description = "AWS region selected for the project."
  value       = var.aws_region
}

output "project_name" {
  description = "Project name."
  value       = var.project_name
}

output "vpc_id" {
  description = "FinServ VPC ID."
  value       = aws_vpc.finserv_vpc.id
}

output "availability_zones" {
  description = "Availability Zones used."
  value = [
    aws_subnet.public_az1.availability_zone,
    aws_subnet.public_az2.availability_zone
  ]
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id
  ]
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]
}
output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster."
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes."
  value       = aws_iam_role.eks_node_role.arn
}
output "eks_cluster_name" {
  description = "FinServ EKS cluster name."
  value       = aws_eks_cluster.finserv_eks.name
}

output "eks_cluster_endpoint" {
  description = "EKS Kubernetes API endpoint."
  value       = aws_eks_cluster.finserv_eks.endpoint
}