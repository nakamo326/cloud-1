resource "aws_alb" "alb" {
  name               = "cloud-1-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet.id, aws_subnet.dummy_subnet.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_route53_record" "www" {
  name    = "www.${local.zone_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

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

resource "aws_security_group" "alb_sg" {
  name        = "cloud-1-alb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.vpc.id

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
