provider "aws" {
  region     = "${var.region}"
}

#creating vpc
resource "aws_vpc" "imagination_demo" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "dedicated"

  tags = {
    Name = "imagination_demo"
  }
}

#creating subnet
resource "aws_subnet" "subnets" {
    # check number of available az's
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  vpc_id     = "${aws_vpc.imagination_demo.id}"
  cidr_block = "${element(var.vpc_subnet,count.index)}"
  tags = {
    Name = "subnet-${count.index+1}"
  }
}

#creating instance
resource "aws_instance" "ans" {
  ami           = "ami-7c1bfd1b"
  instance_type = "t2.micro"

  tags = {
    Name = "ansible"
  }
}


resource "aws_instance" "jen" {
  ami           = "ami-7c1bfd1b"
  instance_type = "t2.micro"

  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "tom" {
  ami           = "ami-7c1bfd1b"
  instance_type = "t2.micro"

  tags = {
    Name = "tomcat"
  }
}
