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
  ami           = "	ami-0cbea92f2377277a4"
  instance_type = "t3.micro"
  security_groups = ["module.minecraft_label.id"]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.51.01.zip
              mkdir minecraft
              unzip bedrock-server-*.zip -d ./minecraft/
              cd minecraft
              LD_LIBRARY_PATH=.
              export LD_LIBRARY_PATH
              chmod +rwx bedrock_server
              ./bedrock_server
                EOF
  
  lifecycle {
    create_before_destroy = true
  }                
}