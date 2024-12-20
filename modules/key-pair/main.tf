resource "aws_key_pair" "magento" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("../main/mykey.pub")
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
