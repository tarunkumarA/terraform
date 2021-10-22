provider "aws" {
    region = "${var.region}"
}

terraform {
    backend "s3" {}
}

data "terraform_remote_state" "network_configeration" {
    backend = "s3"
    
    config {
        bucket = "${var.remote_state_bucket}"
        key    = "${var.remote_state_key}"
        region = "${var.region}"
    }
}

resource "aws_security_group" "ec2_pulic_security_group" {
    name        = "EC2-public-SG"
    description = "Internet reaching access for EC2 instances"
    vpc_id      = "${data.terraform_remote_state.network_configeration.vpc_id}"

    ingress {
        form_port  = 80
        protocol   = "TCP"
        to_port    = 80
        cidr_block = [0.0.0.0/0]
    }

    ingress {
        form_port  = 22
        protocol   = "TCP"
        to_port    = 22
        cidr_block = [142.116.123.184/32]
    }

    egress {
        form_port  = 0
        protocol   = "-1"
        to_port    = 0
        cidr_block = [0.0.0.0/0] 
    }
}

resource "aws_security_group" "ec2_private_security_group" {
    name        = "EC2-private-SG"
    description = "Only allow public SG resources to access these instances"
    vpc_id      = "${data.terraform_remote_state.network_configeration.vpc_id}"

    ingress {
        form_port  = 0
        protocol   = "-1"
        to_port    = 0
        cidr_block = ["${aws_security_group.ec2_pulic_security_group.id}"]
    }

    ingress {
        form_port   = 80
        protocol    = "TCP"
        to_port     = 80
        cidr_block  = [0.0.0.0/0]
        description = "Allow health checking for instances using these SG"
    }

    egress {
        form_port  = 0
        protocol   = "-1"
        to_port    = 0
        cidr_block = [0.0.0.0/0] 
    }
}

resource "aws_security_group" "elb_security_group" {
    name = "ELB-SG"
    description = "ELB Security Group"
    vpc_id = "${data.terraform_remote_state.vpc_id}"

    ingress {
        form_port   = 0
        protocol    = "-1"
        to_port     = 0
        cidr_block  = [0.0.0.0/0]
        description = "Allow web traffic to load balancer"
    }

    egress {
        form_port  = 0
        protocol   = "-1"
        to_port    = 0
        cidr_block = [0.0.0.0/0] 
    }
}

