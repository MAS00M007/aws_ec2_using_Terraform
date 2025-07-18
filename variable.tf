variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_ami_id" {
  default = "ami-0f918f7e67a3323f0"
  type    = string
}

variable "aws_default_root_storage_size" {
  default = 8
  type    = number
}

variable "env" {
  default = "production"
  type    = string
}