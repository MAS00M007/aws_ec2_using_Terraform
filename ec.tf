resource "aws_key_pair" "my_key_new" {
  key_name   = "terra-key-ec2_new"
  public_key = file("terra-key-ec2.pub")

}


resource "aws_default_vpc" "default_vpc" {


}

resource "aws_security_group" "my-aws_security_group" {
  name        = "automate-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_default_vpc.default_vpc.id

  tags = {
    Name = "automate-sg"
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow custom port access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

resource "aws_instance" "my_instance" {
  for_each = tomap({
    t2_micro_node  = "t2.micro"
    # t2_small_node  = "t2.small"
    # t2_medium_node = "t2.medium"
  })

  depends_on = [aws_security_group.my-aws_security_group, aws_key_pair.my_key_new]

  key_name        = aws_key_pair.my_key_new.key_name
  security_groups = [aws_security_group.my-aws_security_group.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")


  root_block_device {
    volume_size = var.env == "production" ? 10 : var.aws_default_root_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
    Environment = var.env
  }
}

# resource "aws_instance" "my_new_instance" {
#     ami = "unknown"
#     instance_type = "unknown"
# }