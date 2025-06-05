variable "key_name" {
  description = "name of the Key Pair"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

# variable "private_subnet" {
#   description = "CIDR blocks for private subnets"
#   type        = string
# }


variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "nginx_instance_type" {
  description = "Instance type for nginx host"
  type        = string
}

variable "nginx_ami" {
  description = "AMI ID for nginxs host"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for app host"
  type        = string
}

variable "app_ami" {
  description = "AMI ID for app host"
  type        = string
}


variable "sonar_instance_type" {
  description = "Instance type for sonar host"
  type        = string
}

variable "sonar_ami" {
  description = "AMI ID for soanrqube host"
  type        = string
}

variable "nexus_instance_type" {
  description = "Instance type for nexus host"
  type        = string
}

variable "nexus_ami" {
  description = "AMI ID for nexus host"
  type        = string
}

variable "my_public_ip" {
  description = "Public IP address for sg rules"
  type        = string
}