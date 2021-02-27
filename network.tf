resource "aws_internet_gateway" "main-igw" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = format("%s-%s-igw", var.dns_name, var.account_environment)
    }
}

resource "aws_route_table" "public-subnet-rt" {
    vpc_id = "${aws_vpc.main.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //Route table uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.main-igw.id}" 
    }
    
    tags = {
        Name = format("%s-%s-igw", var.dns_name, var.account_environment)
    }
}

resource "aws_route_table_association" "RT-public-subnet-1-associate"{
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    route_table_id = "${aws_route_table.public-subnet-rt.id}"
}

resource "aws_route_table_association" "RT-public-subnet-2-associate"{
    subnet_id = "${aws_subnet.public-subnet-2.id}"
    route_table_id = "${aws_route_table.public-subnet-rt.id}"
}

resource "aws_route_table_association" "RT-public-subnet-3-associate"{
    subnet_id = "${aws_subnet.public-subnet-3.id}"
    route_table_id = "${aws_route_table.public-subnet-rt.id}"
}
