resource "aws_instance" "ec2" {
  # Ubuntu 22.04 LTS TODO: check the latest version
  ami                    = "ami-0eba6c58b7918d3a1"
  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
  tags = {
    Name = "cloud-1-ec2"
  }
}

# security group for ec2, allow http traffic
resource "aws_security_group" "ec2_sg" {
  name   = "cloud-1-ec2-sg"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "cloud-1-ec2-sg"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_SSM_Role"
  role = aws_iam_role.ec2_role.name
}

data "aws_iam_policy_document" "ssm_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "EC2_SSM_Role"
  assume_role_policy = data.aws_iam_policy_document.ssm_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
