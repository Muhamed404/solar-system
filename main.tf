provider "aws" {
    region = "us-east-2"
}


resource "aws_instance" "Solar-System-EC2" {
    ami = "ami-06cb4d48053a9622f"
    instance_type = "t2.micro"
    tags = {
      Name = "app-dev"
    }
  
}


output "public_ip" {
    value = aws_instance.Solar-System-EC2.public_ip
  
}


