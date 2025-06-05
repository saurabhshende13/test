output "nginx_public_ip" {
  description = "Public IP of Nginx Server"
  value       = aws_instance.nginx[0].public_ip
}

output "app_public_ip" {
  description = "Public IP of App Server"
  value       = aws_instance.app[0].public_ip
}

output "sonarqube_public_ip" {
  description = "Public IP of SonarQube Server"
  value       = aws_instance.sonarqube.public_ip
}