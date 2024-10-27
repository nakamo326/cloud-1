resource "aws_alb" "alb" {
  name               = "cloud-1-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet.id, aws_subnet.dummy_subnet.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_security_group" "alb_sg" {
  name        = "cloud-1-alb-sg"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "cloud-1-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/healthz"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "204"
  }
}

resource "aws_alb_target_group_attachment" "alb_target_group_attachment" {
  target_group_arn = aws_alb_target_group.alb_target_group.arn
  target_id        = aws_instance.ec2.id
}
