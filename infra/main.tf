module "minecraft_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  context    = module.this.context
  attributes = ["minecraft", "server"]
  enabled    = module.this.enabled
}

resource "aws_security_group" "instance" {
  name        = module.minecraft_label.id
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 19132
    to_port     = 19132
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "minecraft" {
  ami           = var.ami
  instance_type = "t3.micro"
  security_groups = [module.minecraft_label.id]
  user_data = <<-EOF
              #!/bin/bash
              ./bedrock_server
                EOF
  
  lifecycle {
    create_before_destroy = true
  }     

  tags = {
    Name = module.minecraft_label.id
  }           
}
