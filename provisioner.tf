resource "null_resource" "cluster_data_setup" {
  provisioner "local-exec" {
    command = "./setup.sh"
    environment = {
      CLUSTER_NAME       = aws_eks_cluster.eks-cluster.name 
      REGION             = var.region
    }
  }
  depends_on = [aws_eks_cluster.eks-cluster, aws_eks_node_group.eks_node_group_public]
}
