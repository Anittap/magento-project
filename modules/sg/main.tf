resource "aws_security_group" "alb" {
  name        = "frontend"
  description = "Allow traffic to lb"
  vpc_id      = var.magento_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-alb"
  }
}
resource "aws_security_group" "magento" {
  name        = "magento"
  description = "Allow traffic to backend"
  vpc_id      = var.magento_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-magento"
  }
}
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow traffic to bastion"
  vpc_id      = var.magento_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-bastion"
  }
}
resource "aws_security_group" "elasticsearch" {
  name        = "elasticsearch"
  description = "Allow traffic to elasticsearch"
  vpc_id      = var.magento_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-elasticsearch"
  }
}
resource "aws_security_group" "mysql" {
  name        = "mysql"
  description = "Allow traffic to mysql"
  vpc_id      = var.magento_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-mysql"
  }
}
resource "aws_vpc_security_group_ingress_rule" "alb" {
  for_each          = toset(var.alb_ports)
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "es-tcp-swarm" {
  for_each          = toset(var.docker_tcp_ports)
  security_group_id = aws_security_group.elasticsearch.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "magento-tcp-swarm" {
  for_each          = toset(var.docker_tcp_ports)
  security_group_id = aws_security_group.magento.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "mysql-tcp-swarm" {
  for_each          = toset(var.docker_tcp_ports)
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "es-udp-swarm" {
  for_each          = toset(var.docker_udp_ports)
  security_group_id = aws_security_group.elasticsearch.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "udp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "magento-udp-swarm" {
  for_each          = toset(var.docker_udp_ports)
  security_group_id = aws_security_group.magento.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "udp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "mysql-udp-swarm" {
  for_each          = toset(var.docker_udp_ports)
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "udp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "magento_private_http" {
  for_each                     = toset(var.magento_ports)
  security_group_id            = aws_security_group.magento.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = each.key
  ip_protocol                  = "tcp"
  to_port                      = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "magento_remote_access" {
  security_group_id            = aws_security_group.magento.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port                    = var.ssh_port
  ip_protocol                  = "tcp"
  to_port                      = var.ssh_port
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "bastion_access" {
  for_each          = toset(var.bastion_ports)
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "elasticsearch_access" {
  for_each          = toset(var.elasticsearch_ports)
  security_group_id = aws_security_group.elasticsearch.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "mysql_access" {
  for_each          = toset(var.mysql_ports)
  security_group_id = aws_security_group.mysql.id
  referenced_security_group_id = aws_security_group.magento.id  # Restrict access to only Magento SG
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "alb_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "magento_ipv4" {
  security_group_id = aws_security_group.magento.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "bastion" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "elasticsearch" {
  security_group_id = aws_security_group.elasticsearch.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

