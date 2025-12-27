module "vpc" {
  source = "../../modules/vpc"
  env = "dev"
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
  env = "dev"
  allowed_ssh_cidr = ["0.0.0.0/0"]
}

module "s3" {
    source = "../../modules/s3"
    env = "dev"
}

module "iam" {
  source = "../../modules/iam"
  env    = "dev"
}

module "ec2" {
  source = "../../modules/ec2"

  ami                  = "ami-02b8269d5e85954ef"
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.public_subnet_id
  security_group_ids   = [module.security_group.sg_id]
  iam_instance_profile   = module.iam.instance_profile
  env                  = "dev"
}
