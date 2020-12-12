provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

//vpc 

resource "aws_vpc" "default" {

    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
	   environment = "${var.environment}"
    }
}

// internet gateway

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

// subnets

resource "aws_subnet" "subnets" {

    count = "${length(var.vpc_cidrs)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.vpc_cidrs, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"

    tags = {

         Name = "terraform_subnet_${count.index+1}"
    }
}



// route table

resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

// route table association

resource "aws_route_table_association" "terraform-public" {
    count = "${length(var.vpc_cidrs)}"
    subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}


