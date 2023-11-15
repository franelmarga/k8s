resource "aws_instance" "k8s_master" {
  ami           = "ami-0a0d9cf81c479446a" # Linux
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "k8s_master"
  }
}


resource "aws_instance" "k8s_worker1" {
  ami           = "ami-0a0d9cf81c479446a"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "k8s_worker1"
  }
}

resource "aws_instance" "k8s_worker2" {
  ami           = "ami-0a0d9cf81c479446a"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "k8s_worker2"
  }
}
