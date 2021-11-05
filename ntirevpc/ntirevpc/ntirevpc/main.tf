
resource "aws_vpc" "ntire" {
  cidr_block       = var.ntire_cidr
  instance_tenancy = "default"
  
  tags = {
    Name = "Network"
  }
}


#subnet assigning
resource "aws_subnet" "subnets" {

    count = length(var.ntire_sn_azs)
    
    cidr_block = cidrsubnet(var.ntire_cidr, 8, count.index)
    
  vpc_id     = aws_vpc.ntire.id
  #cidr_block = var.ntire_subnet_cidrs[count.index]
  availability_zone =var.ntire_sn_azs[count.index]
  tags = {
    Name = var.ntire_sn_tags[count.index]
  }
}

# resource "aws_subnet" "sn_PROD" {
#   vpc_id     = aws_vpc.ntire.id
#   cidr_block = var.ntire_subnet_cidrs[1]
#   availability_zone =var.ntire_sn_azs[1]
#   tags = {
#     Name = var.ntire_sn_tags[1]
#   }
# }

# resource "aws_subnet" "sn_QA" {
#   vpc_id     = aws_vpc.ntire.id
#   cidr_block = var.ntire_subnet_cidrs[2]
#   availability_zone =var.ntire_sn_azs[2]
#   tags = {
#     Name = var.ntire_sn_tags[2]
#   }
# }

resource "aws_internet_gateway" "ntire_igw" {
  vpc_id = aws_vpc.ntire.id

  tags = {
    name = "ntire-igw"
  }
  
}

#route table
resource "aws_route_table" "pulicrt" {
  vpc_id = aws_vpc.ntire.id
  route = [ ]

  tags = {
    "name" = "ntire-publicrt"
  }
  
}

#route table
resource "aws_route" "publicroute" {
  route_table_id = aws_route_table.pulicrt.id
  destination_cidr_block = "0.0.0.0/16"
  gateway_id = aws_internet_gateway.ntire_igw.id
  
}

resource "aws_route_table_association" "publicRTassociation" {
  count = length(var.web_subnet_indexes)
  subnet_id = aws_subnet.subnets[var.web_subnet_indexes[count.index]].id 
  route_table_id = aws_route_table.pulicrt.id  
}

resource "aws_security_group" "websg" {
  name = "openhttp"
  description = "open ssh and http"
  vpc_id = aws_vpc.ntire.id

  tags = {
    "name" = "open http"

  }
  
}

resource "aws_security_group_rule" "webSGhttp" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.websg.id
  
}


resource "aws_instance" "webserver1" {
  ami = "ami-00782a7608c7fc226"   #ami for ubuntu
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id = aws_subnet.subnets[0].id  
  tags = {
    "name" = "webserver"
  }
}

