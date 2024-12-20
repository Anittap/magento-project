resource "aws_lb" "magento" {
  name               = "${var.project_name}-${var.project_environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-${var.project_environment}-alb"

  }
}
resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = var.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
}
resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = var.alb_arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener_rule" "host_header" {
  listener_arn = aws_lb_listener.front_end_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }

  condition {
    host_header {
      values = ["${var.project_environment}.${var.domain_name}"]
    }
  }
}
resource "aws_route53_record" "alb" {
  zone_id = var.zone_id
  name    = "${var.name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.magento.dns_name
    zone_id                = aws_lb.magento.zone_id
    evaluate_target_health = true
  }
}
