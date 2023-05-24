provider "aws" {
    region = var.AWS_REGION 
}

data "aws_ami" "whitelist_ubuntu" {
    most_recent = true
    owners = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_availability_zones" "available" {}


resource "aws_key_pair" "whitelist_key" {
    key_name = var.KEY_NAME 
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "whitelist_srv" {
    ami = data.aws_ami.whitelist_ubuntu.id
    instance_type = var.INSTANCE_TYPE 
    availability_zone = data.aws_availability_zones.available.names[0]
    key_name = aws_key_pair.whitelist_key.key_name 
    vpc_security_group_ids = [
        aws_security_group.whitelist_sg.id, 
    ]   

    tags = {
        Name = "Whitelist-Server"
    }

    
    provisioner "local-exec" {
        command = "echo Public IP: ${self.public_ip}"
    }

    provisioner "file" {
        source = "config.sh"
        destination = "/tmp/config.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/config.sh",
            "sudo sed -i -e 's/\r$//' /tmp/config.sh",
            "sudo /tmp/config.sh",
        ]
    }

    connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}

# output public_ip {
#         value = aws_instance.ApacheInstance.public_ip
#     }