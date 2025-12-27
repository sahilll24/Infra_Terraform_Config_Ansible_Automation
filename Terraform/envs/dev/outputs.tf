output "ansible_inventory" {
  value = {
    app = {
      instance_id = module.ec2.instance_id
      region      = var.aws_region
      ssm_bucket  = module.s3.bucket_name
    }
  }
}