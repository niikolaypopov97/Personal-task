#Load Balancer
resource "aws_lb" "my-lb" {
  name               = var.lb_name
  internal           = var.lb_internal
  ip_address_type    = var.lb_ip_type
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.my-srv-sg.id]
  subnets            = module.vpc.public_subnets
}

#Target group creating
resource "aws_lb_target_group" "my-tg" {
  health_check {
    interval            = 10
    path                = var.tg_path
    protocol            = var.tg_protocol
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
  name     = var.tg_name
  port     = 80
  protocol = var.tg_protocol
  vpc_id   = module.vpc.vpc_id
}


resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = 80
  protocol          = var.tg_protocol
  default_action {
    target_group_arn = aws_lb_target_group.my-tg.arn
    type             = var.tg_lb_listener
  }
}