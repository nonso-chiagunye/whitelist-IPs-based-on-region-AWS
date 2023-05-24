# variable "AWS_ACCESS_KEY" {}

# variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    default = "us-east-1"
}

# variable "AMIS" {
#     type = map
#     default = {
#         us-east-1 = "ami-007855ac798b5175e"
#         us-east-2 = "ami-0a695f0d95cefc163"
#         us-west-1 = "ami-014d05e6b24240371"
#         us-west-2 = "ami-0fcf52bcf5db7b003"
#     }
# }

variable "PATH_TO_PRIVATE_KEY" {
    description = "Private Key Path"
    default = ""         # private key path
}

variable "PATH_TO_PUBLIC_KEY" {
    description = "Public Key Path"
    default = ""         # public key path
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}

variable "KEY_NAME" {
    type = string 
    default = ""            # key name 
}

variable "INSTANCE_TYPE" {
    default = "t2.micro"
}

variable "ENVIRONMENT" {
    default = "Development"
}

# variable "whitelist_sg_ports" {
#     type = list(number)
#     default = [22, 80, 443]
# }
