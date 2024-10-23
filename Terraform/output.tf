
output "vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

output "instance_public_ip" {
  value = aws_instance.TerraformInstance.public_ip
}
