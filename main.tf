provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test_server" {
  ami           = "ami-0015e1184ccba865e"
  instance_type = "t4g.micro"
  tags = {
    Name = "TestServer"
  }
}

resource "aws_instance" "prod_server" {
  ami           = "ami-0015e1184ccba865e"
  instance_type = "t4g.micro"
  tags = {
    Name = "ProdServer"
  }
}



output "test_server_ip" {
  value = aws_instance.test_server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod_server.public_ip
}
