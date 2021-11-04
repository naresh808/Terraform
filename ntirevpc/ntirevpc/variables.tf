
## variable for ntire vpc region
variable "ntire_region" {
    type = string
    default = "ap-south-1"
}


#variable for ntire vpc cidr
variable "ntire_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}

#variable for ntire vpc cidr
variable "ntire_subnet_cidrs" {
    type = list(string)
    default = [ "10.0.1.0/24" ,"10.0.2.0/24" , "10.0.3.0/24" ,  "10.0.4.0/24" ,"10.0.5.0/24" , "10.0.5.0/24" ]
  
}


variable "ntire_sn_azs" {
    type = list(string)
    default = [ "ap-south-1a" , "ap-south-1a" , "ap-south-1a" , "ap-south-1b" , "ap-south-1b" , "ap-south-1b" ]
  
}

variable "ntire_sn_tags" {
    type = list(string)
    default = [ "dev" , "prod" , "qa" , "dev1" , "prod1" , "qa1" ] 

  
}

variable "web_subnet_indexes" {
    type = list(string)
    default = [ 0 ]
  
}