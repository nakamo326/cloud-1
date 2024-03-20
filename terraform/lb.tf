
# resource "aws_alb_listener" "front_end" {
#   load_balancer_arn = aws_alb.alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.front_end.arn
#   }
# }

# resource "aws_alb_target_group" "front_end" {
#   name     = "tf-example-lb-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = "vpc-abcde012" // あなたの VPC ID

#   health_check {
#     enabled             = true
#     interval            = 30
#     path                = "/"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }
# }

# resource "aws_security_group" "alb_sg" {
#   name = "allow_tls"

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_s3_bucket" "lb_logs" {
#   bucket = "my-loadbalancer-logs"
#   acl    = "private"
# }

# resource "aws_route53_record" "www" {
#   name    = "www.yourdomain.com" // あなたのドメイン名
#   type    = "A"
#   zone_id = "your_zone_id" // あなたの Route 53 ホストゾーンの ID

#   alias {
#     name                   = aws_alb.alb.dns_name
#     zone_id                = aws_alb.alb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_instance" "web" {
#   ami                    = "ami-abc12345" // 適切な AMI ID
#   instance_type          = "t2.micro"     // インスタンスタイプ
#   key_name               = "keypair"      // キーペア
#   vpc_security_group_ids = ["sg-abc12345"] // セキュリティグループ
#   subnet_id              = "subnet-abcde012" // サブネットID

#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_instance.web.id
#   allocation_id = aws_eip.eip.id
# }

# resource "aws_eip" "eip" {
#   vpc = true
# }

