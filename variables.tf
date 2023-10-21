variable "vpc_name" {
  default = "my-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#Launch template related variables
variable "lt_name" {
  default = "my-lt"
}

variable "lt_ami" {
  default = "ami-0a7abae115fc0f825"
}

variable "lt_instance" {
  default = "t2.micro"
}

#ASG related variables
variable "asg_name" {
  default = "my-asg"
}

variable "asg_max_size" {
  default = 2
}

variable "asg_min_size" {
  default = 1
}

variable "asg_des_size" {
  default = 2
}

variable "asg_health_check_period" {
  default = 300
}

variable "asg_health_check" {
  default = "EC2"
}

#LoadBalancer related variables

variable "lb_name" {
  default = "my-lb"
}

variable "lb_internal" {
  default = false
}

variable "lb_ip_type" {
  default = "ipv4"
}

variable "lb_type" {
  default = "application"
}

#Target group related variables

variable "tg_name" {
  default = "my-tg"
}

variable "tg_path" {
  default = "/wp-admin/install.php"
}

variable "tg_protocol" {
  default = "HTTP"
}

variable "tg_lb_listener" {
  default = "forward"
}

#RDS related vars
variable "rds_name" {
  default = "my-db"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_version" {
  default = "5.7"
}

variable "rds_instance" {
  default = "db.t2.micro"
}

variable "rds_db_name" {
  default = "wordpress"
}

variable "rds_username" {
  default = "admin"
}

variable "rds_password" {
  default = "rootpass"
}

variable "rds_param_group" {
  default = "default.mysql5.7"
}