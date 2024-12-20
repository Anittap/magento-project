cidr_block          = "17.0.0.0/16"
project_name        = "magento"
project_environment = "development"
region              = "us-east-1"
owner               = "Anitta"
bits                = 4
magento_ports       = ["80"]
docker_tcp_ports    = ["2377", "7946"]
docker_udp_ports    = ["4789"]
mysql_ports         = ["3306"]
elasticsearch_ports = ["9200", "9300"]
bastion_ports       = ["22"]
ssh_port            = "22"
instance_type = { "elasticsearch" = "t2.small", "mysql" = "t2.micro"
"magento" = "t2.micro" }
ami_id_map = {
  "ap-south-1" = "ami-078264b8ba71bc45e"
  "us-east-1"  = "ami-0fff1b9a61dec8a5f"
  "us-east-2"  = "ami-09da212cf18033880"
}
troubleshooting          = true
magento_desired_size     = 3 
magento_max_size         = 6
magento_min_size         = 1
other_desired_size       = 1
other_max_size           = 1
other_min_size           = 1
enable_elb_health_checks = { "production" = true, "development" = false }
alb_ports                = ["80", "443"]
domain_name              = "anitta.cloud"
