resource "aws_instance" "TerraformInstance" {
   ami                         = "ami-0e86e20dae9224db8" # Ubuntu Server 20.04 LTS (Free Tier eligible in us-east-1)
  instance_type               = "t2.medium"   
  subnet_id                   = aws_subnet.terraform-subnet.id
  associate_public_ip_address = true
   key_name                    = "new-key" # Add this line

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "TerraformInstance"
  }  
}



resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Security group to allow HTTP, custom port 8081, and SSH traffic"
  vpc_id      = aws_vpc.terraform-vpc.id # Associate with the correct VPC

  # Ingress rules (incoming traffic)
  
  # Allow HTTP traffic
  ingress {
    description = "Allow HTTP (IPv4)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP traffic from any IPv4 address
  }

  # Allow custom port 5000
  ingress {
    description = "Allow Custom Port 5000 (IPv4)"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"] # Allows traffic on port 5000 from any IPv4 address
  }

  # Allow SSH traffic
  ingress {
    description = "Allow SSH (IPv4)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"] # Allows SSH traffic from any IPv4 address
  }


  tags = {
    Name = "allow_http_ssh"
  }
}

# Associate subnet with route table

