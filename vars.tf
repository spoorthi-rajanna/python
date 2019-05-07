variable "region" {
 default = "eu-west-2"
 
}

variable "vpc_cidr" {
 default = "10.0.0.0/16"
}

variable "vpc_subnet" {
    type = "list"
 default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24"]

}

variable "ec2_ami" {
    default = "ami-500d9530"
  
}

data "aws_availability_zones" "azs" {}


