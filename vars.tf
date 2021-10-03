variable "subnet" {
  type = map(any)
  default = {
    "vpcsubnet"              = "10.0.0.0/16"
    "publicSubnet1"          = "10.0.0.0/25"
    "publicSubnet2"          = "10.0.0.128/25"
    "privateSubnet1"         = "10.0.1.0/25"
    "privateSubnet2"         = "10.0.1.128/25"
    "destination_cidr_block" = "0.0.0.0/0"
    "My_Ip"                  = "0.0.0.0/0"
    "bastion_private_ip"     = "10.0.0.0/0"
  }
}

variable "name" {
  type = map(any)
  default = {
    "VPC"                          = "VPC"
    "key_name"                     = "umanath_session"
    "availability_zone_1"          = "ap-south-1a"
    "availability_zone_2"          = "ap-south-1b"
    "availability_zone_3"          = "ap-south-1c"
    "Public-Subnet-1"              = "Public-Subnet-1"
    "Public-Subnet-2"              = "Public-Subnet-2"
    "Private-Subnet-1"             = "Private-Subnet-1"
    "Private-Subnet-2"             = "Private-Subnet-2"
    "IGW"                          = "IGW"
    "NAT"                          = "NAT"
    "publicSubnetRouteTableName"   = "Route-pub-01/02"
    "privateSubnetRouteTableName"  = "Route-priv-01/02"
    "Public-Subnet-SG"             = "Public-Subnet-SG"
    "Private-Subnet-SG"            = "Private-Subnet-SG"
    "ec2_Instance_pub1"            = "ec2_Instance_pub1"
    "ec2_Instance_pub2"            = "ec2_Instance_pub2"
    "ec2_Instance_pub3"            = "ec2_Instance_pub3"    
    "ec2_Instance_pri1"            = "ec2_Instance_pri1"
    "ec2_Instance_pri2"            = "ec2_Instance_pri2"
    "ec2_Instance_pri3"            = "ec2_Instance_pri3"

    "ec2_ubuntu_volume_size"       = "8"
    "ec2_redhat_volume_size"       = "10"
    
    "alb"                          = "alb"
    "tomcat"                       = "tomcat"
  }

}


variable "IME_Ubuntu" {
  type = map(any)
  default = {
    "IMEimage" = "ami-0c1a7f89451184c8b"

  }
}

variable "IME_RedHat" {
  type = map(any)
  default = {
    "IMEimage" = "ami-06a0b4e3b7eb7a300"

  }
}


variable "InstanceType_Ubuntu" {
  type = map(any)
  default = {
    "instance_type" = "t3.medium"
  }
}


variable "InstanceType_RedHat" {
  type = map(any)
  default = {
    "instance_type" = "t3.medium"
  }
}



