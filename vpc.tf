#VPC

resource "aws_vpc" "VPC" {
  cidr_block       = var.subnet.vpcsubnet
  instance_tenancy = "default"

  tags = {
    Name = "Umanath-VPC"
    #Name = var.name.VPC
  }
}


# Public Subnet 1

resource "aws_subnet" "publicSubnet1" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnet.publicSubnet1
  availability_zone       = var.name.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-1"
    #Name = var.name.Public-Subnet-1 
  }
}


# Public Subnet 2

resource "aws_subnet" "publicSubnet2" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnet.publicSubnet2
  availability_zone       = var.name.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}


## Private Subnet 1
#
#resource "aws_subnet" "privateSubnet1" {
#  vpc_id                  = aws_vpc.VPC.id
#  cidr_block              = var.subnet.privateSubnet1
#  availability_zone       = var.name.availability_zone_1
#  map_public_ip_on_launch = false
#
#  tags = {
#    Name = "Private-Subnet-1"
#  }
#}
#
#
## Private Subnet 2
#
#resource "aws_subnet" "privateSubnet2" {
#  vpc_id                  = aws_vpc.VPC.id
#  cidr_block              = var.subnet.privateSubnet2
#  availability_zone       = var.name.availability_zone_1
#  map_public_ip_on_launch = false
#
#  tags = {
#    Name = "Private-Subnet-2"
#  }
#}


#Internet Gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "Umanath-IGW"
  }
}


# Public Route Table

resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "Public-Route-Table"
  }
}


# Public Route Table Routes (Attaching IGW)

resource "aws_route" "publicRoutes" {
  route_table_id         = aws_route_table.publicRouteTable.id
  destination_cidr_block = var.subnet.destination_cidr_block
  gateway_id             = aws_internet_gateway.IGW.id
}


# Subnet Association to Public Route Table

resource "aws_route_table_association" "publicSubnetAssociation1" {
  subnet_id      = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table.publicRouteTable.id
}

resource "aws_route_table_association" "publicSubnetAssociation2" {
  subnet_id      = aws_subnet.publicSubnet2.id
  route_table_id = aws_route_table.publicRouteTable.id
}


## Generate Elastic Ip
#
#resource "aws_eip" "NAT_eip" {
#  vpc = true
#}
#
#
## NAT Gateway
#
#resource "aws_nat_gateway" "NAT" {
#  allocation_id = aws_eip.NAT_eip.id
#  subnet_id     = aws_subnet.publicSubnet1.id
#  tags = {
#    Name = "NAT-GATEWAY-Umanath"
#  }
#}


## Private Route Table
#
#resource "aws_route_table" "privateRouteTable" {
#  vpc_id = aws_vpc.VPC.id
#  tags = {
#    Name = "Private-Route-Table"
#  }
#}
#
#
## Private Route Table Routes
#
#resource "aws_route" "privateRoutes" {
#  route_table_id         = aws_route_table.privateRouteTable.id
#  destination_cidr_block = var.subnet.destination_cidr_block
#  nat_gateway_id         = aws_nat_gateway.NAT.id
#}
#
#
## Subnet Association to Private Route Table
#
#resource "aws_route_table_association" "privateSubnetAssociation" {
#  subnet_id      = aws_subnet.privateSubnet1.id
#  route_table_id = aws_route_table.privateRouteTable.id
#}
#
#resource "aws_route_table_association" "privateSubnetAssociation2" {
#  subnet_id      = aws_subnet.privateSubnet2.id
#  route_table_id = aws_route_table.privateRouteTable.id
#}




# ************************************************************************************



# Public Security Group

resource "aws_security_group" "publicSubnet" {
  # ... other configuration ...
  vpc_id = aws_vpc.VPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.subnet.My_Ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.subnet.destination_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.subnet.destination_cidr_block]
  }

  tags = {

    Name = "Public-Security-Group"
  }
}


##Private SG
#
#resource "aws_security_group" "privateSubnet" {
#  vpc_id = aws_vpc.VPC.id
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = [var.subnet.bastion_private_ip]
#  }
#
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = [var.subnet.destination_cidr_block]
#  }
#  tags = {
#
#    Name = "Private-Security-Group"
#
#  }
#}



# Public Instance 1


resource "aws_instance" "ec2pub1" {
  ami                    = var.IME_Ubuntu.IMEimage
  instance_type          = var.InstanceType_Ubuntu.instance_type
  key_name               = var.name.key_name
  vpc_security_group_ids = [aws_security_group.publicSubnet.id]

  subnet_id              = aws_subnet.publicSubnet1.id
  
  ebs_block_device {
    device_name       = "/dev/sda1"
    volume_size       = var.name.ec2_ubuntu_volume_size  # Size of the volume in gibibytes (GiB)
  }
  
  tags = {

    Name = "Public-Instance-1-Ubuntu"
  }
}


# Public Instance 2


resource "aws_instance" "ec2pub2" {
  ami                    = var.IME_Ubuntu.IMEimage
  instance_type          = var.InstanceType_Ubuntu.instance_type
  key_name               = var.name.key_name
  vpc_security_group_ids = [aws_security_group.publicSubnet.id]

  subnet_id              = aws_subnet.publicSubnet2.id
  
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size          = var.name.ec2_ubuntu_volume_size  # Size of the volume in gibibytes (GiB)
  }

  tags = {

    Name = "Public-Instance-2-Ubuntu"
  }
}



# Public Instance 3


resource "aws_instance" "ec2pub3" {
  ami                    = var.IME_RedHat.IMEimage
  instance_type          = var.InstanceType_RedHat.instance_type
  key_name               = var.name.key_name
  vpc_security_group_ids = [aws_security_group.publicSubnet.id]

  subnet_id              = aws_subnet.publicSubnet1.id
  
  ebs_block_device {
    device_name       = "/dev/sda1"
    volume_size       = var.name.ec2_redhat_volume_size  # Size of the volume in gibibytes (GiB)
  }
  
  tags = {

    Name = "Public-Instance-3-RedHat"
  }
}


## Private Instance 1
#
#resource "aws_instance" "ec2pri1" {
#  ami                    = var.IME.IMEimage
#  instance_type          = var.InstanceType_Ubuntu.instance_type
#  key_name               = var.name.key_name
#  vpc_security_group_ids = [aws_security_group.privateSubnet.id]
#
#  subnet_id              = aws_subnet.privateSubnet1.id
#
#  ebs_block_device {
#    device_name       = "/dev/sda1"
#    volume_size       = var.name.ec2_ubuntu_volume_size  # Size of the volume in gibibytes (GiB)
#  }
#
#  tags = {
#
#    Name = "Private-Instance-1-Ubuntu"
#  }
#}
#
#
## Private Instance 2
#
#resource "aws_instance" "ec2pri2" {
#  ami                    = var.IME.IMEimage
#  instance_type          = var.InstanceType_Ubuntu.instance_type
#  key_name               = var.name.key_name
#  vpc_security_group_ids = [aws_security_group.privateSubnet.id]
#
#  subnet_id              = aws_subnet.privateSubnet2.id
#
#  ebs_block_device {
#    device_name       = "/dev/sda1"
#    volume_size       = var.name.ec2_ubuntu_volume_size  # Size of the volume in gibibytes (GiB)
#  }
#
#  tags = {
#
#    Name = "Private-Instance-2-Ubuntu"
#  }
#}
#
#
#
## Private Instance 3
#
#resource "aws_instance" "ec2pri3" {
#  ami                    = var.IME.IMEimage
#  instance_type          = var.InstanceType_Ubuntu.instance_type
#  key_name               = var.name.key_name
#  vpc_security_group_ids = [aws_security_group.privateSubnet.id]
#
#  subnet_id              = aws_subnet.privateSubnet2.id
#
#  ebs_block_device {
#    device_name       = "/dev/sda1"
#    volume_size       = var.name.ec2_redhat_volume_size  # Size of the volume in gibibytes (GiB)
#  }
#
#  tags = {
#
#    Name = "Private-Instance-3-RedHat"
#  }
#}
#
#
###############################################################################################################################################
#
#
#
#
#
## Application LoadBalancer
#
#
#resource "aws_lb" "alb" {
#  name                       = "application-load-balancer"
#  internal                   = false
#  load_balancer_type         = "application"
#  security_groups            = [aws_security_group.publicSubnet.id]
#  subnets                    = [aws_subnet.publicSubnet1.id, aws_subnet.publicSubnet2.id]
#  enable_deletion_protection = false
#}
#
#
#resource "aws_alb_target_group" "tomcat" {
#  name        = "tomcat"
#  port        = "8080"
#  protocol    = "HTTP"
#  vpc_id      = aws_vpc.VPC.id
#  target_type = "instance"
#  health_check {
#    healthy_threshold   = "5"
#    unhealthy_threshold = "2"
#    interval            = "30"
#    matcher             = "200"
#    path                = "/"
#    port                = "traffic-port"
#    protocol            = "HTTP"
#    timeout             = "5"
#  }
#  tags = {
#    Name = "tomcat-target-group"
#  }
#}
#
#
#resource "aws_alb_listener" "tomcat" {
#  load_balancer_arn = aws_lb.alb.id
#  port              = "8080"
#  protocol          = "HTTP"
#  default_action {
#    target_group_arn = aws_alb_target_group.tomcat.arn
#    type             = "forward"
#  }
#}
#
#resource "aws_lb_target_group_attachment" "tomcat_server1" {
#  target_group_arn = aws_alb_target_group.tomcat.arn
#  #target_id        = aws_instance.ec2_Instance_pri1.id
#  target_id = aws_instance.ec2pri1.id
#}
#
#resource "aws_lb_target_group_attachment" "tomcat_server2" {
#  target_group_arn = aws_alb_target_group.tomcat.arn
#  target_id        = aws_instance.ec2pri2.id
#}





