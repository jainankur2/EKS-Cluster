resource "aws_eks_cluster" "eks-cluster" {
  name = format("%s-%s-eks-cluster", var.dns_name, var.account_environment)
  role_arn = aws_iam_role.eks-cluster-iam.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids = ["${aws_subnet.public-subnet-1.id}","${aws_subnet.public-subnet-2.id}","${aws_subnet.public-subnet-3.id}"] 
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
  tags = {
    Name = format("%s-%s-eks-cluster", var.dns_name, var.account_environment)
  }
}


#EKS Cluster node group
# Nodes in public subnet
resource "aws_eks_node_group" "eks_node_group_public" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = format("%s-%s-eks-node-group-public", var.dns_name, var.account_environment)
  node_role_arn   = aws_iam_role.eks-cluster-node-iam.arn
  subnet_ids      = ["${aws_subnet.public-subnet-1.id}","${aws_subnet.public-subnet-2.id}","${aws_subnet.public-subnet-3.id}"]
  ami_type       = var.ami_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
tags = {
    Name = format("%s-%s-eks-node-group-public", var.dns_name, var.account_environment)
  }
# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
