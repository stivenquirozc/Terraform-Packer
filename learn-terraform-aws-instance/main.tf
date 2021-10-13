terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

  resource "aws_elb" "backend" {
  name = "backend-lb-squiroz-rumpup"
  internal           = true
  security_groups = ["sg-07439af226c920943"]
  subnets = ["subnet-0d74b59773148d704", "subnet-038fa9d9a69d6561e"]

  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:3000/"
  }

  listener {
    lb_port = 3000
    lb_protocol = "http"
    instance_port = "3000"
    instance_protocol = "http"
  }
}

resource "aws_launch_configuration" "backend" {
  name   = "terraform-lc-example-backend-squiroz"
  image_id      = "ami-0bcdbeca59a7e6a06" 
  associate_public_ip_address = false
  key_name = "squiroz"
  security_groups = ["sg-07439af226c920943"]
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "backend" {
  name = "asg-backend-squiroz-terraform"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 1  
  health_check_type    = "ELB"
  vpc_zone_identifier       = ["subnet-038fa9d9a69d6561e", "subnet-0d74b59773148d704"]
  load_balancers = ["backend-lb-squiroz-rumpup"]
  launch_configuration      = "terraform-lc-example-backend-squiroz"

  lifecycle {
    create_before_destroy = true
    }
  }

resource "aws_elb" "frontend" {
  name = "frontend-lb-squiroz-rumpup"
  internal           = false
  security_groups = ["sg-070706447508199bc"]
  subnets = ["subnet-0088df5de3a4fe490", "subnet-055c41fce697f9cca"]

  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:3030/"
    }

  listener {
    lb_port = 3030
    lb_protocol = "http"
    instance_port = "3030"
    instance_protocol = "http"
  }
}

  resource "aws_launch_configuration" "frontend" {
  name   = "terraform-lc-example-frontend-squiroz"
  image_id      = "ami-074df41120ce378df" 
  associate_public_ip_address = true
  key_name = "squiroz"
  security_groups = ["sg-070706447508199bc"]
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name = "asg-frontend-squiroz-terraform"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 1  
  health_check_type    = "ELB"
  vpc_zone_identifier       = ["subnet-0088df5de3a4fe490", "subnet-055c41fce697f9cca"]
  load_balancers = ["frontend-lb-squiroz-rumpup"]
  launch_configuration      = "terraform-lc-example-frontend-squiroz"

  lifecycle {
    create_before_destroy = true
    }
  }

resource "aws_db_instance" "mysql" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t2.micro"
  name                 = "movie_db"
  username             = "applicationuser"
  password             = "applicationuser"
  skip_final_snapshot  = false
  db_subnet_group_name = "default-group-private-rumpup-squiroz"
  vpc_security_group_ids = ["sg-068b2c295fafbcbf8"]
  publicly_accessible = false

   }





  
