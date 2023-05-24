data "aws_ip_ranges" "whitelist_ips" {
 regions = ["me-central-1","eu-west-2"]  # UAE and UK 
 services = ["ec2"]
}

resource "aws_security_group" "whitelist_sg" {
 name = "${var.ENVIRONMENT}-whitelist-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = data.aws_ip_ranges.whitelist_ips.cidr_blocks
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = data.aws_ip_ranges.whitelist_ips.cidr_blocks
    # cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    # cidr_blocks = data.aws_ip_ranges.whitelist_ips.cidr_blocks
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Egress 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
   CreateDate = data.aws_ip_ranges.whitelist_ips.create_date
   SyncToken = data.aws_ip_ranges.whitelist_ips.sync_token
 }
}
