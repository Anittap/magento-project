resource "aws_autoscaling_attachment" "backend_asg_tg_attachment" {
  lb_target_group_arn    = var.tg_arn
  autoscaling_group_name = var.asg_id
}
