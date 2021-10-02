output "VPC" {
  description = "vpc id"
  value       = aws_vpc.VPC.id
}


output "Public-Subnet-1" {
  description = "public Subnet 1 Id"
  value       = aws_subnet.publicSubnet1.id
}


output "Public-Subnet-2" {
  description = "public Subnet 2 Id"
  value       = aws_subnet.publicSubnet2.id
}



#output "Private-Subnet-1" {
#  description = "private Subnet 1 Id"
#  value       = aws_subnet.privateSubnet1.id
#}


#output "Private-Subnet-2" {
#  description = "private Subnet 2 Id"
#  value       = aws_subnet.privateSubnet2.id
#}


output "Internet-Gateway-IGW" {
  description = "aws internet gateway Id"
  value       = aws_internet_gateway.IGW.id
}


#output "NAT-Gateway" {
#  description = "aws NAT  gateway  Id "
#  value       = aws_nat_gateway.NAT.id
#}


output "Route-Table-Public" {
  description = "aws public Route Table Id"
  value       = aws_route_table.publicRouteTable.id
}


#output "Route-Table-Private" {
#  description = "aws private  Route Table Id"
#  value       = aws_route_table.privateRouteTable.id
#
#}

# ******************************************************************************************************

output "Security-Group-Public" {
  description = "aws_security_groupPublicSubnet"
  value       = aws_security_group.publicSubnet.id

}


#output "Security-Group-Private" {
#  description = "aws_security_groupPrivateSubnet"
#  value       = aws_security_group.privateSubnet.id
#
#}


output "Public-Instance-1-Ubuntu" {
  description = "AWS Instance Public 1  Id"
  value       = aws_instance.ec2pub1.id

}

output "Public-Instance-2-Ubuntu" {
  description = "AWS Instance Public 2  Id"
  value       = aws_instance.ec2pub2.id

}


output "Public-Instance-3-RedHat" {
  description = "AWS Instance Public 3  Id"
  value       = aws_instance.ec2pub3.id

}


#output "Private-Instance-1" {
#  description = "AWS Instance Private 1  Id"
#  value       = aws_instance.ec2pri1.id
#
#}
#
#output "Private-Instance_2" {
#  description = "AWS Instance Private 2  Id"
#  value       = aws_instance.ec2pri2.id
#
#}
#
#
#output "Private_Instance_3" {
#  description = "AWS Instance Private 3  Id"
#  value       = aws_instance.ec2pri3.id
#
#}





