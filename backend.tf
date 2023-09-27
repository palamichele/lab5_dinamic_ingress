terraform { // This is to Store Remote State
  backend "s3" {
    bucket = "michele-terraform-back-end"   // Bucket where to SAVE Terraform State
    key    = "test/dinamic_ingress/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "eu-west-3"                       // Region where bucket created
  }
}
