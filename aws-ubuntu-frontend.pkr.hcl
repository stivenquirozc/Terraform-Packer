packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-chroot" "ubuntunew" {
  source_ami                  = "ami-0b5105157a6aad00b"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0088df5de3a4fe490"
  ssh_keypair_name            = "squiroz"
  ssh_private_key_file        = ""
  security_group_id           = "sg-070706447508199bc"
  access_key                  = ""
  ami_name                    = "Packer_frontend_new"
  region                      = "us-west-1"
  secret_key                  = ""
  associate_public_ip_address = "true"
  source_ami_filter {
    filters = {
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
   }
  ssh_username = "ubuntu"
  run_tags = {
    project     = "ramp-up-devops"
    responsible = "squiroz"
  }
  tags = {
    project     = "ramp-up-devops"
    responsible = "squiroz"
  }
  run_volume_tags = {
    project = "ramp-up-devops"
    responsible = "squiroz"
  }
}

build {
  name = "learn-packer"
  sources = ["source.amazon-ebs.ubuntu"  ]
}