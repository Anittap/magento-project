provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.project_environment
      Owner       = var.owner
      Project     = var.project_name
    }
  }
}
