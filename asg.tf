#Configuration for launch template
resource "aws_launch_template" "my-lt" {
  name          = var.lt_name
  image_id      = var.lt_ami
  instance_type = var.lt_instance
  key_name      = aws_key_pair.my-key-pair.key_name
  user_data     = filebase64("./user_data.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile1.name
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = "${element(module.vpc.public_subnets, 0)}"
    security_groups             = [aws_security_group.my-srv-sg.id]
  }
  depends_on = [aws_db_instance.my-db]
}

#Configuration of ASG
resource "aws_autoscaling_group" "my-asg" {
  name                      = var.asg_name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_des_size
  health_check_grace_period = var.asg_health_check_period
  health_check_type         = var.asg_health_check
  target_group_arns         = [aws_lb_target_group.my-tg.arn]
  vpc_zone_identifier       = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.my-lt.id
    version = aws_launch_template.my-lt.default_version
  }

  tag {
    key                 = "Name"
    value               = "my-srv"
    propagate_at_launch = true
  }
  depends_on = [aws_db_instance.my-db]
}

#Attaching ASG to Target group
resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.my-asg.id
  lb_target_group_arn    = aws_lb_target_group.my-tg.arn
}