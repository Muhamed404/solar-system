        provider "aws" {
            region = "us-east-2"
        }


        resource "aws_instance" "Solar-System-EC2" {
            ami = "ami-0cb91c7de36eed2cb"
            instance_type = "t2.micro"
            vpc_security_group_ids = ["sg-004f2c8742a2e24eb"]
            key_name = "ECT-instanses"
            tags = {
            Name = "app-dev"
            }
            user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update -y
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                    sudo apt-get update -y
                    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo usermod -aG docker ubuntu
                    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAzT79BHe8WY8/x4UKQ0bXDUJoWVOrU2/3WwAg6THwJ abdallah@abdallah" >> /home/ubuntu/.ssh/authorized_keys
                    EOF

        
        }

        output "public_ip" {
            value = aws_instance.Solar-System-EC2.public_ip
        
        }