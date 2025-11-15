module "eks" {
  source  = "../modules/eks"
  cluster_name = "zero-trust-cluster"
  region       = "us-east-1"
}
