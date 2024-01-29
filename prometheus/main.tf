terraform {
  backend "s3" {
    bucket = "s3-practice-devops"
    key    = "misc/prometheus/terraform.tfstate"
    region = "us-east-1"

  }
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

resource "aws_instance" "prometheus" {
  ami = data.aws_ami.centos8.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-05760a73b326267cb"]

  tags = {
    Name = "prometheus-server"
  }
}

resource "aws_route53_record" "prometheus" {
  zone_id = "Z082480628W9T5FTT67ES"
  name    = "prometheus"
  type    = "A"
  ttl     = 30
  records = [aws_instance.prometheus.private_ip]
}

resource "aws_route53_record" "prometheus-public" {
  zone_id = "Z09059901XRPHNYMGLMJ4"
  name    = "prometheus-public"
  type    = "A"
  ttl     = 30
  records = [aws_instance.prometheus.public_ip]
}