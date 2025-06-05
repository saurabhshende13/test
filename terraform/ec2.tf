resource "aws_instance" "nginx" {
  count                  = length(var.availability_zones)
  ami                    = var.nginx_ami
  instance_type          = var.nginx_instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name = "${var.environment}-nginx-0${count.index + 1}"
  }
}

resource "aws_instance" "app" {
  count                  = length(var.availability_zones)
  ami                    = var.app_ami
  instance_type          = var.app_instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 14
    encrypted   = true
  }

  tags = {
    Name = "${var.environment}-app-0${count.index + 1}"
  }
}


resource "aws_instance" "sonarqube" {
  ami                    = var.sonar_ami
  instance_type          = var.sonar_instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 13
    encrypted   = true
  }

  tags = {
    Name = "${var.environment}-sonarqube"
  }
}