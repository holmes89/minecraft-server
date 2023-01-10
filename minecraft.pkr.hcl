variable "ami_id" {
  type    = string
  default = "ami-0cbea92f2377277a4"
}

locals {
  app_name = "minecraft"
}

source "amazon-ebs" "minecraft" {
  ami_name      = "packer-${local.app_name}"
  instance_type = "t3.micro"
  region        = "us-east-2"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  tags = {
    Env  = "dev"
    Name = "packer-${local.app_name}"
  }
}

build {

  sources = ["source.amazon-ebs.minecraft"]
  provisioner "file" {
    source      = "server.properties"
    destination = "/tmp/server.properties"
  }
  provisioner "shell" {
    script = "scripts/minecraft-install.sh"
  }

  
}
