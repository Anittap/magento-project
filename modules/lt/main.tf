resource "aws_launch_template" "lt" {
  name                   = "${var.project_name}-${var.project_environment}-${var.name}-${var.alias}"
  image_id               = lookup(var.ami_id_map, var.region)
  instance_type          = lookup(var.instance_type, var.name, "t2.micro")
  key_name               = var.key_pair
  vpc_security_group_ids = [var.sg_magento_id]
  description            = "Launch template for asg"

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-${var.name}-${var.alias}"
    Environment = var.project_environment
    Owner       = var.owner
    Project     = var.project_name
  }
  user_data = var.user_data
  lifecycle {
    create_before_destroy = true
  }
}
