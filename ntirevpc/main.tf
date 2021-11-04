
resource "aws_vpc" "ntire" {
  cidr_block       = var.ntire_cidr
  instance_tenancy = "default"
  
  tags = {
    Name = "Network"
  }
}


#subnet assigning
resource "aws_subnet" "sunbnets" {

    count = 3

  vpc_id     = aws_vpc.ntire.id
  cidr_block = var.ntire_subnet_cidrs[count.index]
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